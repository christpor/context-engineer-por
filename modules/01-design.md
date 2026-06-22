## Module 1 — Context Architecture Design

Build the 3-layer system. Every serious project needs exactly this structure.

### Layer 1 — Router File — MAX 50 LINES
- Named per your tool (see Universal Vocabulary table in SKILL.md)
- **Only contains:** read AGENT.md → read SKILL_INDEX before tasks → run git check → wait for GO
- Auto-readable in under 5 seconds
- Never put architecture details here — those live in AGENT.md
- Never commit to git — machine-specific paths, private rules
- **Self-Healing Trigger:** add one line — *"If you see a Compacting/Compressing/Compacted system message → immediately re-read AGENT.md + SKILL_INDEX."* The Router File is reloaded into context every turn, so it survives a context compaction that wipes the short-term buffer — making it the one safe place to put the recovery instruction. Cheap insurance against an agent waking up amnesiac.

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
