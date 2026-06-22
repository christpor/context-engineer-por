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

Tone: direct, peer-to-peer. Zero fluff. Show plan → wait for GO → execute.

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

**This table verified: June 2026.** AI tools change fast — these principles apply to ANY new terminal agent or IDE. Always verify at the tool's official docs.

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
> **JUST-IN-TIME RETRIEVAL:** Do NOT load the whole skill. Read the specific file path listed below ONLY when needed.

| Situation | Module Path |
|-----------|-------------|
| Read about the 3-Layer Architecture / Mental Model | `modules/00-architecture.md` |
| New project, no context structure | `modules/01-design.md` |
| Context files too long / bloated | `modules/02-trim.md` |
| Session getting heavy, token warning | `modules/03-session.md` |
| "Which model should I use?" | `modules/04-model-tier.md` |
| Fresh agent confused, missed context | `modules/05-amnesia.md` |
| SKILL_INDEX broken or missing | `modules/06-skill-index.md` |
| Session ending, need to hand off | `modules/07-handoff.md` |
| Agent repeated a past mistake | `modules/08-correction.md` |
| Switching AI tools mid-project | `modules/09-cross-tool.md` |
| Anytime (retrieval + done-discipline) | `modules/10-universal.md` |
| Existing project, full audit | `references/01-audit-protocol.md` |

---

## Output Contract — Full Context Engineering Deliverable

When you finish designing or fixing a project's context architecture (Module 1), verify all 8 exist:

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

**v4.0 — 2026-06-22.** Modularized for extreme token optimization. Reduced core file to ~100 lines. Implemented Cross-Tool Handoff and Cross-Skill Isolation.

**The meta-rule:** If something in this skill will be wrong in 6 months → make it a principle instead of a specific name. The TIER system and PRINCIPLES stay valid forever.
