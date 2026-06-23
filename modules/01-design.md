## Module 1 — Context Architecture Design

Build the Progressive Context system based on the Project Tier (Tier 1: Small | Tier 2: Core | Tier 3: Enterprise).

### Layer 1 — Router File — MAX 50 LINES
- Named per your tool (e.g., `CLAUDE.md`, `.cursorrules`, `AGENTS.md`)
- **Mandatory Injection:** `"Ponytail Mode ON: Deletion > Modification > Addition. Do not write abstractions or boilerplate unless explicitly requested. Stop at the lowest rung."`
- **Only contains:** read AGENT.md → run git check → wait for GO
- Never put architecture details here — those live in AGENT.md
- **Self-Healing Trigger:** *"If you see a Compacting/Compressing system message → re-read AGENT.md."*

### Layer 2 — Agent Brain (context/AGENT.md) — MAX 100 LINES
**Must contain all 9 sections or it fails the Amnesia Test:**
1. Project name + stack + deadline (1 line)
2. WHO YOU ARE — agent persona + tone + hard rules (5 lines)
3. WHO THE DEVELOPER IS — constraints + philosophy (5 lines)
4. SESSION START — numbered protocol. (If Tier 3, inject Pushback tripwires here: *"If draft < 8, load pushback skill"*).
5. CURRENT STATE — branch + last commit + pending (6 lines)
6. NEXT TASKS — priority order (6 lines)
7. KEY FILES & UTILS — 5–8 files. **Must list shared project utilities** to mathematically enforce reuse over boilerplate generation. (6 lines)
8. RUN + PUSH — exact commands. **Must include:** *"Shortest working diff wins. Delete boilerplate before committing."* (6 lines)
9. LAST SESSION HANDOFF — what was built + next step. **Must include:** *"Ponytail Diff: +X / -Y lines."* (10 lines)

### Layer 3 — Deep Reference (context/LAWS.md) — NO LIMIT (Tier 3 Only)
- Never loaded at session start — only when agent needs deep context.
- **Mandatory Section:** `LAZY DEV ARCHITECTURE` — Promotes the 7-rung Ponytail Ladder and the "Bug Fix = Root Cause" rule.
- Organized by: commit history → hard lessons → bug patterns → architecture laws.

### Output Contract for Module 1
Deliver only what is required for the chosen tier.

**Tier 1:**
1. Router File
2. `context/AGENT.md`
3. Exact command: `mkdir -p context`

**Tier 2:**
* Plus:
4. `.learnings/errors/` initialized
5. Exact command: `mkdir -p context .learnings/errors`

**Tier 3:**
* Plus:
6. `context/LAWS.md` skeleton
7. `context/SKILL_INDEX.md` starter routing table
8. `context/CONTEXT_ENGINEERING.md`
