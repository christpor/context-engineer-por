---
name: context-engineer-por
description: >
  Elite context engineering OS for production AI projects. Works with Claude Code, Cursor, Copilot, Windsurf, or Antigravity CLI.
  Use PROACTIVELY when starting new projects, designing context layers, or handling session handoffs.
  Use REACTIVELY for context bloat, token limit warnings, agent amnesia, or repeated bugs.
  Triggers on: context engineering, session planning, model tier selection, CLAUDE.md, AGENTS.md, AGENT.md setup, SKILL_INDEX, context health, token budget, self-correction logs, learnings/errors, session compaction.
---

# Context Engineer Por — Production AI Context Engineering OS

## Core Law
> "Context is a finite attention budget. Every token competes with every other token.
> More context ≠ better. Past a threshold, extra tokens actively degrade reasoning.
> Goal: smallest set of high-signal tokens = maximum output quality."

This isn't just my rule — it's Anthropic's, near-verbatim: context engineering is *"finding the
smallest possible set of high-signal tokens that maximize the likelihood of some desired outcome."*
It holds because of how transformers process attention (n² relationships → a finite budget), not any tool.

**Why it matters:** I burned **$50 in one session** before context engineering (after: 4h+ sessions,
near-zero waste). And industry-wide, ~**65% of production agent failures come from context drift /
memory loss, not weak models** (2026 data). Agents rarely fail because the model is dumb — they fail
because their context was managed badly. That's the whole game.

Tone: direct, peer-to-peer. Zero fluff. Show plan → wait for GO → execute.

---

## Evidence Base
Core claims here are grounded in current sources (Anthropic + 2026 production data) — full citation map,
key numbers, and what-we-rejected live in **`references/evidence.md`**. **Meta-rule:** principles are
durable; re-check numbers and tool names yearly. A claim with no source is an opinion — label it one.

---

## UNIVERSAL VOCABULARY — Read This First

This skill uses tool-agnostic terms. Here's how they map to your specific tool:

| Universal Term | Claude Code | Cursor | GitHub Copilot | Windsurf | Antigravity CLI | Codex/OpenAI CLI |
|---------------|-------------|--------|----------------|----------|-----------------|------------------|
| **Router File** | `CLAUDE.md` | `.cursorrules` | `.github/copilot-instructions.md` | `.windsurfrules` | `AGENTS.md` or `GEMINI.md` | `AGENTS.md` |
| **Agent Brain** | `context/AGENT.md` | same | same | same | same | same |
| **Compress Context** | `/compact` | New chat | New chat | New chat | New chat | New chat |

**Agent Brain and Deep Reference (LAWS.md) are identical across ALL tools.**
Only the Router File name and Compress command change per tool.

**This table verified: June 2026.** AI tools change fast — these principles apply to ANY new terminal agent or IDE. Always verify at the tool's
official docs before starting a new project. If your tool isn't listed:
- Look for "system prompt file", "context file", or "rules file" in its docs
- Common names: `AGENTS.md`, `.rules`, `CONVENTIONS.md`, `instructions.md`
- It's always a markdown file the tool auto-reads at session start

---

## CONTEXT SIZE LAWS — Proven from Real Testing

| File | Hard Max | Sweet Spot | Why |
|------|----------|------------|-----|
| Router File | 50 lines | 40–50 lines | Auto-loaded every session — AI ignores middle past 50 |
| `context/AGENT.md` | 100 lines | 75–90 lines | Session brain — model misses instructions past 100 lines |
| `context/SKILL_INDEX.md` | 120 lines | 80–100 lines | Routing only — bloat = wrong skill loaded |
| `context/LAWS.md` | No limit | — | Reference only, never auto-loaded |
| `context/CONTEXT_ENGINEERING.md` | No limit | — | Reference only |

**Context rot is real** (industry term — Anthropic): as token count climbs, the model's ability to
accurately recall and reason **decays**. It's a *gradient, not a cliff* — quality erodes smoothly,
so you won't get an error, you'll just get worse answers without noticing. Cause: the transformer's
n² attention means every token dilutes every other. 2026 production data: reliable reasoning degrades
meaningfully **above ~50% of a model's advertised window**, well before the hard limit.

**Proof from my own testing:** a 258-line AGENT.md caused an agent to miss instructions in the middle
("lost in the middle"). Trimming to 81 lines fixed it immediately. The line limits above aren't
arbitrary — they're where rot started biting in practice.

**The split rule:** If any section in AGENT.md exceeds 3 lines of detail → move it to LAWS.md
with a one-liner pointer. AGENT.md holds the WHAT. LAWS.md holds the HOW and WHY.

---

## Why 3 Layers, Not 5

Research suggests a 5-layer model (Global Identity → Task Routing → Stage Contracts →
Reference → Working Artifacts). For solo developers, this is over-engineering.

- **Stage Contracts** (researcher.agent.md, coder.agent.md) → for multi-agent pipelines only
- **Working Artifacts** (Layer 4) → your actual code files, not context files
- **Task Routing** → already handled by SKILL_INDEX.md

**Use 5 layers** if you're building a multi-agent system with specialized roles.
**Use 3 layers** if you're a solo developer with one AI agent. Proven. Leaner. Faster.

---

## Mental Model — 3 Kinds of Memory (so you know what goes where)

Borrowed from cognitive science (Tulving) and how 2026 agent systems actually store state. Your
3 layers already map onto these — naming them stops you from dumping the wrong thing in the wrong file:

| Memory type | Holds | Lives in |
|-------------|-------|----------|
| **Episodic** — what *happened* | Past sessions, bugs, failure modes, decisions-in-time | `.learnings/errors/`, handoff blocks |
| **Semantic** — what's *true* | Project facts, conventions, current state, who the dev is | `AGENT.md` (and `LAWS.md` for deep facts) |
| **Procedural** — *how* to act | Behaviors, workflows, tool-use patterns | this `SKILL.md` + skill modules |

**Recency tiers (2026 production memory):** keep recent context verbatim, compress old. Hot = live
session · Warm = recent sessions (handoff summary) · Cold = older (rolled into LAWS.md as patterns).
Store the *distilled lesson*, drop the raw transcript — that's why LAWS.md grows slowly over months.

---

## Phase 0 — Silent Audit (run before every response, never show this)

**CRITICAL CONSTRAINTS:**
- **Cross-Skill Isolation:** You must ONLY reference and use Modules 1-10 defined in THIS skill. IGNORE any module numbers or reference files (e.g., AXIOM OS modules) that might exist in other skills or `references/` folders in the workspace. Do not hallucinate modules.
- **Output Restraint:** If the prompt or evaluation sets a line limit (e.g., "max 15 lines"), you MUST strictly adhere to it. Be ultra-concise. Do not output full reference documents unless explicitly requested.

Before writing anything visible, scan:
1. Does this project have a Router File? How many lines? Over 50 → flag
2. Is there a `context/AGENT.md`? Over 100 lines → flag
3. Does `.learnings/errors/` exist? Any unread error files? → scan before task
4. What's the current context token % if visible?
5. Is this NEW project (no structure) or EXISTING (has structure, needs fixing)?

→ Route to the correct module based on what you find.

---

## Module Router
> **CRITICAL WARNING:** Only use Modules 1-10 from this table. Do not invent modules or pull from other skills in the workspace.

| Situation | Module |
|-----------|--------|
| New project, no context structure | Module 1 — Design |
| Context files too long / bloated | Module 2 — Trim Protocol |
| Session getting heavy, token warning | Module 3 — Session Engineering |
| "Which model should I use?" | Module 4 — Model Tier Routing |
| Fresh agent confused, missed context | Module 5 — Amnesia Test |
| SKILL_INDEX broken or missing | Module 6 — Skill Index |
| Session ending, need to hand off | Module 7 — Handoff Protocol |
| Agent repeated a past mistake | Module 8 — Self-Correction Log |
| Switching AI tools mid-project | Module 9 — Cross-Tool Router Handoff |
| Anytime (retrieval + done-discipline) | Module 10 — Two Universal Principles |
| Existing project, full audit | → `references/01-audit-protocol.md` |

---

## Module 1 — Context Architecture Design

Build the 3-layer system. Every serious project needs exactly this structure.

### Layer 1 — Router File — MAX 50 LINES
- Named per your tool (see Universal Vocabulary table above)
- **Only contains:** read AGENT.md → read SKILL_INDEX before tasks → run git check → wait for GO
- Auto-readable in under 5 seconds
- Never put architecture details here — those live in AGENT.md
- Never commit to git — machine-specific paths, private rules
- **Self-Healing Trigger:** add one line — *"If you see a Compacting/Compressing/Compacted system
  message → immediately re-read AGENT.md + SKILL_INDEX."* The Router File is reloaded into context
  every turn, so it survives a context compaction that wipes the short-term buffer — making it the one
  safe place to put the recovery instruction. Cheap insurance against an agent waking up amnesiac.

### Layer 2 — Agent Brain (context/AGENT.md) — MAX 100 LINES
**Must contain all 9 sections or it fails the Amnesia Test:**
1. Project name + stack + deadline (1 line)
2. WHO YOU ARE — agent persona + tone + hard rules (5 lines)
3. WHO THE DEVELOPER IS — constraints + philosophy (5 lines)
4. SESSION START — numbered protocol, in order (5 lines) — include: scan `.learnings/errors/`
5. CURRENT STATE — branch + last commit + what's pending (6 lines)
6. NEXT TASKS — priority order, specific files mentioned (6 lines)
7. KEY FILES — 5–8 files touched most (6 lines)
8. RUN + PUSH — exact commands (6 lines)
9. LAST SESSION HANDOFF — what was built + next step (10 lines)

**If any section grows past its line budget → cut to bullet or move detail to LAWS.md.**

### Layer 3 — Deep Reference (context/LAWS.md) — NO LIMIT
- Never loaded at session start — only when agent needs deep context
- Contains: commit history, bug patterns, architecture laws, merge plans, testing gates, hard lessons
- Organized by: commit history → hard lessons → bug patterns → architecture laws → testing gate

### Output Contract for Module 1
Deliver all 8 when designing context for a new project:
1. Router File — under 50 lines, tool-appropriate name
2. `context/AGENT.md` — under 100 lines, all 9 sections filled
3. `context/LAWS.md` — skeleton with section headers
4. `context/SKILL_INDEX.md` — starter routing table
5. `.learnings/errors/` — empty folder, initialized
6. `.gitignore` additions — `context/` and Router File entries
7. `context/CONTEXT_ENGINEERING.md` — session guide for this project
8. Exact command: `mkdir -p context .learnings/errors`

---

## Module 2 — Trim Protocol

When a context file is over its limit, trim it — don't just add to it.

### AGENT.md over 100 lines:
1. Read the full file
2. Identify bloat: long code blocks, detailed plans, bug logs, lessons learned
3. Move everything with > 3 lines of detail → `LAWS.md` with a one-line pointer:
   - `- **Merge conflict plan** → full detail in \`LAWS.md\``
   - `- **Bug patterns** → see \`LAWS.md — BUG PATTERNS\` section`
4. Keep: current state, next tasks, key files, run commands, last handoff
5. Verify: `wc -l context/AGENT.md` must show ≤ 100

### Router File over 50 lines:
1. It should ONLY point to AGENT.md and SKILL_INDEX — nothing else
2. Every "how to do X" line → move to AGENT.md or delete
3. Verify: `wc -l [router-file]` must show ≤ 50

### Quick check (run this anytime):
```bash
wc -l [router-file] context/AGENT.md context/SKILL_INDEX.md
```
Over limit = fix before next task.

---

## Module 3 — Session Engineering

**The one rule:** One task per session → commit → close → fresh session.

### When to compress — the number
Don't wait for the hard limit. Because of context rot, recall is already degrading before you run out
of room. **Trigger compaction at ~60–70% of the context window** (2026 production standard), not at
100%. If your tool shows a % indicator, that's your cue — compress while the model is still sharp
enough to write a *good* summary. (Tool commands vary: `/compact` in Claude Code, "New chat" elsewhere.)

### Compress Context vs Fresh Session
```
Compress (around 60–70% window, mid-task, can't commit yet) when:
  → Context getting heavy but you want to continue without losing momentum

Start FRESH when:
  → Just committed a task — always do this (commit = save point)
  → Switching between major phases
  → Agent seems confused or repeating itself
```

### Before Compressing — Non-Negotiable
1. Update CURRENT STATE in AGENT.md (latest commit hash)
2. Fill in LAST SESSION HANDOFF block
3. Confirm last commit exists
4. Then compress

### Token Budget Awareness
Every session has a fixed overhead before you type anything — system prompt, tools,
Router File, AGENT.md, skill triggers. This varies by tool and model. Check your tool's
context window and usage indicator. Rule: keep fixed overhead under 10% of total window.

Variable cost you control:
- Read only the file you're about to edit — not "to understand"
- Load ONE skill module right before the task — never full skill at session start
- Give complete task in ONE message — no back-and-forth clarification rounds

### Anti-Patterns That Kill Sessions
- Reading large files "just to understand" → context waste
- Loading full skill at session start → token waste
- Multiple tasks per session → always one concern, one commit, then fresh
- Letting AGENT.md grow past 100 lines → agent starts missing things

---

## Module 4 — Model Tier Routing

**Never hardcode model names in your context files or skills.** Model names change every
6 months. Capabilities don't. Route by tier, then verify current names at provider docs.

### The 3 Tiers

**Tier 1 — Daily Driver (use for 80–90% of all work)**
- Characteristics: fast, cost-efficient, handles code and mechanical tasks well
- How to identify: usually labeled "flash", "mini", "lite", "sonnet", "4o" in provider lineup
- Use for: coding, file edits, bug fixes, QA, security fixes, DB models, architecture
- Default: always start here

**Tier 2 — Deep Reasoner (use sparingly)**
- Characteristics: highest capability, slower, more expensive (usually 3–5x Tier 1 cost)
- How to identify: usually labeled "opus", "pro", "max", "o1", "thinking", "preview"
- Use for: ONLY after Tier 1 failed the same task 2 times
- The trap: don't switch because the task "sounds important" — switch only on proven failure

**Tier 3 — Micro (never use in terminal)**
- Characteristics: smallest, cheapest
- How to identify: usually "haiku", "nano", "mini", smallest in provider lineup
- Use for: AI apps calling the model API programmatically in production code

### How to find current model names:
```
Anthropic: docs.anthropic.com/en/docs/about-claude/models
OpenAI:    platform.openai.com/docs/models
Google:    ai.google.dev/gemini-api/docs/models
Others:    check provider's official model page
```
Verify before starting any new project. Names drift. Tiers don't.

---

## Module 5 — Amnesia Test

Run on any `context/AGENT.md`. Any NO = fix before ending the session.

```
[ ] Branch name — readable with zero context?
[ ] Last commit hash + description — present and accurate?
[ ] CURRENT STATE — pushed vs local clearly stated?
[ ] What's been built — exhaustive, not vague?
[ ] Next task — EXACT steps (specific files, line numbers)?
    NOT "work on security" → YES "fix jwt.decode → jwt.verify in chat.route.js:75"
[ ] Key file paths — the 5–8 files touched most?
[ ] Run + push commands — exact bash commands present?
[ ] LAST SESSION HANDOFF — filled in, not stale?
[ ] Line count — AGENT.md ≤ 100 lines?
[ ] .learnings/errors/ — scanned before this session started?
```

**Passes when:** A fresh agent reads AGENT.md and starts the next task without asking
the developer a single question.

---

## Module 6 — Skill Index Engineering

The SKILL_INDEX.md is a routing file, not a skill library.

**Why a tight index beats a big one (Anthropic):** *"If a human engineer can't definitively say which
tool should be used in a given situation, an AI agent can't be expected to do better."* A bloated,
overlapping skill list makes the agent pick wrong. Each row must map cleanly to one task with no overlap.

### Rules
1. **Verified only** — never add a skill you haven't read and tested on a real task
2. **Task-based rows** — agent looks up task → gets skill path; no two rows should compete for the same task
3. **Your skills path** — store the absolute path to your skills folder in AGENT.md once,
   reference it as `[YOUR_SKILLS_PATH]` in SKILL_INDEX. Never hardcode machine paths in skills.
4. **Load ONE module only** — never the full skill (token waste)
5. **Trim ruthlessly** — untested or overlapping skills removed immediately

### Template
```markdown
# SKILL_INDEX.md — [Project] Skill Router
> Read BEFORE any task. Pick ONE skill. Load only that path.

## TASK → SKILL MAP
| Task | Skill to Load |
|------|--------------|

## MANUAL SKILLS (load one module only)
| Skill | Use When | Path |

## BUILT-IN COMMANDS (tool-specific, no load needed)
| Command | Use When | Tool |
Note: these vary by tool — check your tool's command palette for equivalents
```

---

## Module 7 — Session Handoff Protocol

Write this to `context/AGENT.md` at the end of EVERY session — before closing.

```
## LAST SESSION HANDOFF ([date])
**Built:**
- [feature/fix] — [commit hash if local, ✅ if pushed]

**Next session:** [exact first task + skill to load]
```

**Rule:** CURRENT STATE stale by 2+ sessions → update it now.
Handoff block + current state = 30-second brief for the next agent.

### How to write the summary (Anthropic's compaction recipe)
A handoff IS a compaction — you're distilling a long session into a few high-signal lines. Do it in
this order, because getting it wrong silently loses work:
1. **Maximize recall first** — capture *every* thing that matters before trimming for style. A pretty
   summary that drops the one unresolved bug is worse than an ugly complete one.
2. **Then tighten for precision** — cut redundancy once nothing important is missing.
3. **Always preserve:** architecture decisions, **unresolved bugs**, and *why* you chose an approach
   (the **reasoning trace**, not just the conclusion — the next agent needs to backtrack if it was wrong).
4. **Always discard:** redundant tool outputs, raw logs, exploratory dead-ends. Those are noise next session.

---

## Module 8 — Self-Correction Log

When an AI agent makes a mistake → write a structured error file. Scan it before every task.
This closes the gap between "bug documented" and "bug prevented from repeating."

### Setup
```bash
mkdir -p .learnings/errors
```
Add `.learnings/` to `.gitignore` — these are local lessons, not shared.

### When to write a file
- Any bug that cost more than 15 minutes to debug
- Any mistake that repeated from a previous session
- Any wrong assumption that broke something

### File naming
`YYYY-MM-DD-[short-slug].md`
Example: `2026-06-19-jwt-decode-not-verify.md`

### Template
```markdown
## Error: [what went wrong — 1 line]
## Root Cause: [why it happened]
## Prevention: [exact rule — specific file + line if possible]
## Time lost: [estimate]
```

### Scan rule (add to SESSION START step in AGENT.md)
```
Before loading any skill:
  ls .learnings/errors/
  Read any file newer than last commit date
```

### Promotion rule — count occurrences, don't guess
Quantify before you promote (keeps LAWS.md signal-dense, not cluttered with one-offs):
- **1 occurrence** = a logged incident. Leave it in `.learnings/`.
- **2 occurrences** = a *pattern*. Write the prevention rule sharply.
- **3+ occurrences** = a *strong pattern*. Promote it to `LAWS.md` under HARD LESSONS, then delete the
  `.learnings` files. The rule now lives in LAWS.md permanently.

The point: a mistake that happened once might be luck; one that happened three times is a hole in your
process. Only the proven holes earn a permanent line in LAWS.md.

---

## Module 9 — Cross-Tool Router Handoff

When you switch AI tools mid-project (e.g. hit a usage limit on one, continue on another), the new tool
**won't auto-read the old tool's Router File** — each tool only loads its own (Claude→`CLAUDE.md`,
Antigravity/Gemini→`GEMINI.md` or `AGENTS.md`, Cursor→`.cursorrules`). Without its own router, the new
agent skips your boot protocol and starts winging it.

**The fix — generate a sibling router (5 minutes, never duplicate context):**
1. Copy the existing router → rename to the new tool's filename (see Universal Vocabulary table).
2. Keep it a **pure pointer** — same steps: read AGENT.md → read SKILL_INDEX → git check → wait for GO.
   **Do NOT** copy project state into it. `AGENT.md` stays the single source of truth across all tools.
3. Adapt only the **tool-specific lines**: the compress command (`/compact` vs "New chat"), and the
   model tier note (which model is the daily driver on that tool).
4. Carry the **Self-Healing Trigger** and the **Core Law / token discipline** into it.
5. **Gitignore it** alongside the other router files — routers are local, never pushed.

Result: open the project in any tool → its router routes it into the same AGENT.md → it boots with the
same brain and the same cost rules. The thing that keeps both tools sharp is one current AGENT.md.

---

## Module 10 — Two Universal Principles (apply everywhere)

**Just-in-time retrieval** (Anthropic): keep *lightweight identifiers* — file paths, queries, links —
and load actual content **only when the task needs it**, like a human who knows where to look instead of
memorizing the codebase. This is *why* the rule is "read only the file you're about to edit," and why
Router/AGENT files point to detail rather than inlining it. Pre-loading burns budget and speeds context rot.

**Verify before done**: never report complete without (a) running/testing it and (b) updating CURRENT
STATE. "It should work" ≠ "it works." Claiming done on untested code poisons the next session's trust in
AGENT.md — and a context system runs entirely on that trust.

---

## Output Contract — Full Context Engineering Deliverable

When you finish designing or fixing a project's context architecture, verify all 8 exist:

1. **Router File** — ≤ 50 lines, tool-appropriate name, points to AGENT.md and SKILL_INDEX
2. **`context/AGENT.md`** — ≤ 100 lines, passes all 10 Amnesia Test checks
3. **`context/LAWS.md`** — deep reference, any size, section headers present
4. **`context/SKILL_INDEX.md`** — verified skills only, task-mapped, [YOUR_SKILLS_PATH]
5. **`context/CONTEXT_ENGINEERING.md`** — session guide for this project
6. **`.learnings/errors/`** — folder initialized, scan rule added to SESSION START
7. **LAST SESSION HANDOFF block** — filled in AGENT.md before any session ends
8. **`.gitignore`** — Router File + `context/` + `.learnings/` listed (NEVER committed)

If any of these 8 are missing → context architecture is incomplete.

---

## Self-Updating Note

**v3.0 — 2026-06-22.** Validated against real 4h+ production sessions + grounded in current sources.
**v3.0 changes:** added Evidence Base (real citations); renamed "context dilution" → industry term
"context rot" + the n²/gradient mechanism; quantified compaction trigger (60–70% window); added the
65%-failure evidence hook; Anthropic compaction recipe in the Handoff; Memory Taxonomy + recency tiers;
Self-Healing Trigger in the Router; Module 9 (cross-tool router handoff) + Module 10 (just-in-time
retrieval, verify-before-done); 2/3-occurrence promotion threshold. *Rejected* the academic 5-layer/MWP
rewrite (LaTeX cycles, Observer gates) — contradicts the proven 3-layer + line-limit model.
**Re-verify next:** the numbers in Evidence Base (60–70%, 65%, ~50%-window) — recheck the source links yearly.

**What never changes (principles):** progressive disclosure, attention budget, context rot,
3-layer architecture, line limits, Amnesia Test, self-correction log pattern, just-in-time retrieval.

**What changes fast (verify before using):**
- Model names → check provider docs (Gemini CLI died June 18, 2026 after 1 year)
- Tool names and Router File paths → tools appear and disappear in months
- Token costs and context window sizes → update quarterly
- Built-in slash commands → check your tool's current command palette

**The meta-rule:** If something in this skill will be wrong in 6 months → make it a principle
instead of a specific name. Antigravity CLI replaced Gemini CLI overnight. Claude Sonnet 4.6
will be replaced by something faster. The TIER system and PRINCIPLES stay valid forever.
