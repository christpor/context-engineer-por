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

Tone: direct, peer-to-peer. Zero fluff. Show plan → wait for GO → execute.

---

## UNIVERSAL VOCABULARY — Read This First

| Universal Term | Claude Code | Cursor | GitHub Copilot | Windsurf | Antigravity CLI |
|---------------|-------------|--------|----------------|----------|-----------------|
| **Router File** | `CLAUDE.md` | `.cursorrules` | `.github/copilot-instructions.md` | `.windsurfrules` | `AGENTS.md` or `GEMINI.md` |
| **Agent Brain** | `context/AGENT.md` | same | same | same | same |
| **Compress Context** | `/compact` | New chat | New chat | New chat | New chat |

**Agent Brain and Deep Reference (LAWS.md) are identical across ALL tools.**

---

## Phase 0 — Silent Audit (run before every response, never show this)

**CRITICAL CONSTRAINTS:**
1. **Zero-Delta Baseline (Ponytail Rule):** New Files = 0 by default. To generate a new file, you must mathematically prove why existing utilities, stdlib, or native features failed (the "Ponytail Ladder").
2. **Cross-Skill Isolation:** ONLY use modules in THIS skill. Do not hallucinate external modules.
3. **Byte-Stable Caching:** Keep System Instructions and Router logic at the absolute top of the context window. Push dynamic variables to the bottom.

Before writing anything visible, scan:
1. Does this project have a Router File? Over 50 lines? → flag
2. Is there a `context/AGENT.md`? Over 100 lines? → flag
3. Are we writing new code? Did we check for existing helpers first?
4. What's the project size? → Select Tier (Tier 1: Small | Tier 2: Core | Tier 3: Enterprise)

→ Route to the correct module based on what you find.

---

## Module Router (Progressive Context Tiers)

> **JUST-IN-TIME RETRIEVAL:** Do NOT load the whole skill. Read the specific file path listed below ONLY when needed.

| Trigger Category | Specific Situation | Module Path |
|------------------|--------------------|-------------|
| **[1] Setup / Architect** | New project design (Tier 1-3 setup) | `modules/01-design.md` |
| | Read about the 3-Layer Architecture | `modules/00-architecture.md` |
| **[2] Trim / Fix Amnesia** | Context bloated, amnesia, token warnings | `modules/02-trim.md` / `03-session.md` |
| | Fresh agent confused, missed context | `modules/05-amnesia.md` |
| **[3] Handoff / Learnings** | Session ending, handoff protocol | `modules/07-handoff.md` |
| | Agent repeated a past mistake | `modules/08-correction.md` |
| **[4] Meta / Tooling** | Switching AI tools mid-project | `modules/09-cross-tool.md` |
| | "Which model should I use?" | `modules/04-model-tier.md` |
| | Existing project full audit | `references/01-audit-protocol.md` |

---

## Output Contract — Progressive Context Setup

When executing Module 1 (Design), build ONLY the files required for the selected Tier:

**Tier 1: Small Project (Scripts/Weekends)**
1. **Router File** — ≤ 50 lines, contains "Ponytail Lazy Dev" mandate.
2. **`context/AGENT.md`** — ≤ 100 lines, must pass Amnesia Test.

**Tier 2: Core Project (Standard)**
* All of Tier 1 +
3. **`.learnings/errors/`** — initialized folder.
4. **LAST SESSION HANDOFF** — block added to AGENT.md tracking Ponytail (+/- diffs).

**Tier 3: Enterprise (Scaled AI System)**
* All of Tier 2 +
5. **`context/LAWS.md`** — Deep reference, includes "Lazy Dev Architecture" rules.
6. **`context/SKILL_INDEX.md`** — Verified skills routing.
7. **Tripwire Integrations** — Pushback gates injected into AGENT.md.

---

## Self-Updating Note
**v4.1 — 2026-06-23.** Master Refactor. Implemented "Lazy Senior Dev" Zero-Delta math, Progressive Context Tiers (1-3), and Byte-Stable Caching prioritization. 
