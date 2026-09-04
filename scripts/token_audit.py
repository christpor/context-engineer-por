#!/usr/bin/env python3
"""Token-budget instrument for context-engineer-por. Stdlib only, no network, no deps.

Closes the gap flagged in pushback review: rules like "keep AGENT.md under 100 lines"
or "summary must be <=20% of what it replaced" are unenforceable without something that
actually counts. This gives you a number to check against instead of a guess.

Token estimate uses the standard ~4 chars/token heuristic (no live Claude tokenizer
available locally) -- good enough for budget flags, not billing-accurate.
"""
import argparse
import os
import sys

CHARS_PER_TOKEN = 4

ROUTER_NAMES = {"CLAUDE.md", ".cursorrules", ".windsurfrules", "copilot-instructions.md", "AGENTS.md", "GEMINI.md"}
BRAIN_NAMES = {"AGENT.md"}
SKIP_DIRS = {".git", "node_modules", ".venv", "venv", "test_venv", ".archive", "__pycache__"}


def read_stats(path):
    with open(path, "r", encoding="utf-8", errors="ignore") as f:
        text = f.read()
    lines = text.count("\n") + (1 if text and not text.endswith("\n") else 0)
    words = len(text.split())
    chars = len(text)
    tokens_est = chars // CHARS_PER_TOKEN
    return {"lines": lines, "words": words, "chars": chars, "tokens_est": tokens_est}


def budget_for(filename):
    if filename in ROUTER_NAMES:
        return 50, "Router File"
    if filename in BRAIN_NAMES:
        return 100, "Agent Brain"
    if filename == "SKILL.md":
        return 500, "Skill file (global CLAUDE.md cap)"
    return None, None


def cmd_audit(args):
    root = args.path
    flagged = 0
    scanned = 0
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = [d for d in dirnames if d not in SKIP_DIRS and not d.startswith(".")]
        for fn in filenames:
            limit, label = budget_for(fn)
            if limit is None:
                continue
            fp = os.path.join(dirpath, fn)
            stats = read_stats(fp)
            scanned += 1
            status = "OVER" if stats["lines"] > limit else "ok"
            if status == "OVER":
                flagged += 1
            print(f"[{status:4s}] {fp}  ({label}, limit {limit})  "
                  f"lines={stats['lines']} words={stats['words']} tokens~{stats['tokens_est']}")
    print(f"\nScanned {scanned} budget-tracked file(s), {flagged} over limit.")
    if flagged:
        sys.exit(1)


def cmd_summary_check(args):
    orig = read_stats(args.original)
    summ = read_stats(args.summary)
    ratio = summ["words"] / orig["words"] if orig["words"] else 0
    cap = args.max_ratio
    status = "PASS" if ratio <= cap else "FAIL"
    print(f"original: {orig['words']} words (~{orig['tokens_est']} tokens)")
    print(f"summary:  {summ['words']} words (~{summ['tokens_est']} tokens)")
    print(f"ratio:    {ratio:.2%}  (cap {cap:.0%})  -> {status}")
    if status == "FAIL":
        sys.exit(1)


def cmd_profile_check(args):
    """Fail when model-profile rows age past --max-days: stale numbers = silent wrong guidance."""
    import datetime
    import re
    default = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "references", "00-model-profiles.md")
    path = args.table or os.path.normpath(default)
    today = datetime.date.today()
    stale = checked = 0
    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            if not line.startswith("|") or "---" in line or line.lower().startswith("| model"):
                continue
            cells = [c.strip() for c in line.strip().strip("|").split("|")]
            m = re.search(r"\d{4}-\d{2}-\d{2}", cells[-1]) if cells else None
            if not m:
                continue
            checked += 1
            age = (today - datetime.date.fromisoformat(m.group())).days
            if age > args.max_days:
                stale += 1
                print(f"[STALE] {cells[0]}: last-verified {m.group()} ({age}d > {args.max_days}d) -> re-verify at provider docs")
            else:
                print(f"[ok   ] {cells[0]}: verified {age}d ago")
    print(f"\nChecked {checked} model row(s), {stale} stale.")
    if stale or not checked:
        sys.exit(1)


def main():
    parser = argparse.ArgumentParser(description="Token-budget instrument for context-engineer-por")
    sub = parser.add_subparsers(dest="command")

    p_audit = sub.add_parser("audit", help="Scan a project for router/brain/skill files over their line budget")
    p_audit.add_argument("path", nargs="?", default=".", help="Root path to scan (default: current dir)")

    p_check = sub.add_parser("summary-check", help="Verify a compressed summary stays within budget of the original")
    p_check.add_argument("original", help="Path to the original (pre-compression) content")
    p_check.add_argument("summary", help="Path to the summary file")
    p_check.add_argument("--max-ratio", type=float, default=0.20, help="Max summary/original word ratio (default 0.20)")

    p_prof = sub.add_parser("profile-check", help="Flag model-profile table rows whose last-verified date has aged out")
    p_prof.add_argument("--table", default=None, help="Path to 00-model-profiles.md (default: sibling references/)")
    p_prof.add_argument("--max-days", type=int, default=90, help="Max age in days before a row is stale (default 90)")

    args = parser.parse_args()
    if args.command == "audit":
        cmd_audit(args)
    elif args.command == "summary-check":
        cmd_summary_check(args)
    elif args.command == "profile-check":
        cmd_profile_check(args)
    else:
        parser.print_help()


if __name__ == "__main__":
    main()
