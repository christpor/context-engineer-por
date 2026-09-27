---
name: context-engineer-por
description: "Context engineering: CLAUDE.md, AGENTS.md, token budgets, session handoffs, context bloat, agent amnesia fixes."
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
1. **Zero-Delta Baseline (Ponytail Rule):** New Files = 0 by default. To generate a new file, you must mathematically prove why existing utilities, stdlib, or native features failed.
2. **Frontmatter Loading:** Never read an entire 500-line skill file just to see what it does. Only read the `name` and `description` YAML frontmatter to save tokens.
3. **Subagent Context Isolation:** Protect the main thread context at all costs. If you need to read 15 web pages or massive files, spawn the **Tri-Node Swarm (3 subagents)**. Force subagents to return JSON/bullets, NOT raw HTML.
4. **Byte-Stable Caching:** Keep System Instructions and Router logic at the absolute top of the context window. Push dynamic variables to the bottom.
5. **Sovereign Security Gate:** Before any session commit or remote push, `sovereign-gate` must exit 0 (zero secret leaks, clean context, verified dependencies).

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
| | Global Second Brain & Epistemic Clone Vault (`brain-log`) | `modules/12-epistemic-clone-vault.md` |
| | Agent repeated a past mistake, or a successful workflow should be captured as a skill | `modules/08-correction.md` |

| **[4] Meta / Tooling** | Switching AI tools mid-project | `modules/09-cross-tool.md` |
| | "Which model should I use?" | `modules/04-model-tier.md` |
| | Model names / windows / burn rates (ONLY file with model-specific numbers) | `references/00-model-profiles.md` |
| | Existing project full audit | `references/01-audit-protocol.md` |
| **[5] Skill Safety** | Creating/updating a skill that touches infra/billing/auth/data | `modules/11-skill-integrity.md` |
| | Post-incident: skill gap caused a billing/security issue | `modules/11-skill-integrity.md` |

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
5. **`context/USER.md`** — The Operator Profile (who the user is, timezone, goals, communication preference).
6. **`context/SOUL.md`** — The Core Personality & Values (temperament, low-latency tone, 7-Rung Ladder rules).
7. **`context/IDENTITY.md`** — The Agent Role & Position (the specific job role and tools scope for this codebase).
8. **`context/SKILL_INDEX.md`** — Verified skills routing guides (e.g., WSL vs macOS).
9. **Tripwire Integrations** — Pushback gates injected into AGENT.md.

**Instrument note:** `scripts/token_audit.py` is the portable, dependency-free measuring tool
this skill ships with (chars/4 heuristic — deliberately model-agnostic, do NOT "fix" it per-model).
In the Skill Factory Lab repo, `first_mate.py audit`/`checkpoint` wraps it — prefer that there.

---

## 🧠 The Cognitive Identity Layer (USER / SOUL / IDENTITY)
Instead of flat text files, the cognitive context layer is structured into three distinct files to define the interactions between the Developer and the AI Agent cleanly:

### 1. `USER.md` — The Operator Profile
Defines the Developer's profile so the agent tailors solutions to their exact style:
* **Who you are:** Title, role, timezone, and professional focus.
* **Core values:** Your priorities (e.g., discipline, speed, safety).
* **Communication preference:** Tone (e.g., direct, peer-to-peer, no filler).

### 2. `SOUL.md` — The Core Personality & Values
Defines the AI's temperament and operational philosophy:
* **Tone & Voice:** How the AI speaks (e.g., Sovereign Cambodian Builder system).
* **Low-Latency rules:** Aggressive CoT bypass for expert requests.
* **Execution rules:** Standard library priority, YAGNI, deletion over addition.

### 3. `IDENTITY.md` — The Agent Position & Role
Defines the AI's specific job description and permissions for this repository:
* **Position title:** (e.g., Elite DevOps Automator / Next.js Co-pilot).
* **Primary responsibilities:** What the agent is responsible for building or auditing.
* **Tool boundaries:** What command groups are permitted (read-only vs write).

---

## Self-Updating Note
**v6.2 — 2026-09-22.** Added Module 12 (Epistemic Clone Vault & Universal Telemetry). Enforced 4-Tier Memory Topology (Tier 0 ≤100-line sprint, Tier 1 TIMELINE.md master table, Tier 2 atomic daily logs, Tier 3 JSONL clone vectors). Integrated `brain-log` cross-project CLI protocol for zero-working-tree-pollution handoffs across disparate repositories.

**v6.1 — 2026-08-24.** Added Module 11 (Skill Integrity Checklist) — mandatory sections for

infra/billing/auth/data-touching skills. Hardened Module 08 with proactive scan (check learnings
+ skill completeness BEFORE executing, not just after mistakes). Extended Reference 01 audit
protocol with 5-point Infra Safety Audit + 3 new red flags. Triggered by billing incident where
`kapi-deployment` skill had no cost section → $5/month burned on idle container.

**v6.0 — 2026-07-02.** Model-agnostic refactor. All model names/IDs/windows/prices now live in
ONE file — `references/00-model-profiles.md` (new model = add one row, zero module edits).
`references/03-model-routing.md` rewritten as tier routing; `modules/04-model-tier.md` deduped
into a router; burn-rate + cache-TTL discipline added to `modules/03-session.md` (the Fable 5
fast-burn lesson). Fork drift resolved: the parallel copy under `skills-por-goal-june-2026/` is
now a stub pointing here.

**v5.4 — 2026-07-01.** Synced forward from a parallel copy of this skill that had drifted
(`skills-por-goal-june-2026/11_automation_builder/context-engineer-por/`) — this file was stale at
v5.0 while that copy reached v5.4. Real changes brought over: Hermes Agent (NousResearch) 4-phase
compression structure in `modules/03-session.md` (not the 50%/85% trigger numbers — no token-counter
instrument exists here to check them against); durable-state-check-before-retry + successful-workflow
capture in `modules/08-correction.md`; and `scripts/token_audit.py` — a real stdlib instrument that
scans for router/brain/skill files over budget and verifies compression-summary ratios, replacing
manual `wc -l`/`wc -w` guesses. First run on this repo caught `.agents/AGENT.md` at 133/100 lines,
since fixed. Both copies should be reconciled properly rather than left as two live forks — flagged.

**v5.0 — 2026-06-30.** Integrated Subagent Swarm context isolation and Frontmatter loading token rules.
