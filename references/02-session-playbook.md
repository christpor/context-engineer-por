# Reference 02 — Session Engineering Playbook
> Load this when planning a multi-session build sprint or debugging session limits.
> Contains: token budget calculator, session map template, compaction flowchart, anti-patterns.

---

## Token Budget Calculator

Every Claude Code session has a fixed base cost before you type a word:

```
FIXED (can't reduce):
  System prompt:          ~7.3k tokens
  System tools:           ~7.1k tokens
  Claude Code skill list: ~4.5k tokens
  CLAUDE.md (auto-read):  ~0.6k tokens
  ──────────────────────────────────────
  Base cost:              ~19.5k tokens

VARIABLE (you control this):
  AGENT.md (read at start):       ~1.2k tokens
  SKILL_INDEX.md (before task):   ~0.8k tokens
  1 AXIOM reference module:       ~2-3k tokens (vs 8k for full skill)
  Each file read:                 ~0.5-5k tokens (stays in context)
  Each exchange (question + answer): ~1-3k tokens
  ──────────────────────────────────────────────
  Typical session at 10% context: ~100k tokens total
```

**Key insight:** The base cost of ~20k tokens is unavoidable. The variable cost is where you win or lose.

### Token-Saving Moves (biggest impact first)
1. Load 1 AXIOM module instead of full skill → saves ~5-6k tokens per session
2. Give complete task in ONE message → saves 3-5 exchanges = ~10k tokens
3. Read only files you're about to edit → saves 1-5k per skipped file
4. Commit and start fresh session → saves all accumulated variable cost
5. Run /compact before switching tasks → saves 20-40k tokens vs letting it grow

---

## 4-Hour Build Sprint Template

For a deadline day (like Baitorng June 18-20), structure time like this:

```
Session 1 — [Task Name] (Model: Sonnet/Opus)
  Start: Open terminal → "Read AGENT.md" → wait for briefing
  Give task: ONE complete message with: what to build + files to touch + success criteria
  Work: build → test → verify
  End: commit → update LAST SESSION HANDOFF → close terminal
  Duration target: 45-75 min

[15 min break — let your brain reset]

Session 2 — [Task Name] (Model: Sonnet/Opus)
  Same protocol. Fresh terminal = fresh token budget.
  ...

Session 3 — [Task Name]
  ...

Session 4 — [Buffer/Review]
  Final review, bug fixes, pre-merge check
  Use Senior Code Reviewer skill or /code-review
```

**Why sessions are separate:** Each fresh terminal = full 1M token budget. Chaining sessions = accumulating noise that degrades reasoning quality over time.

---

## /compact vs Fresh Session Decision Flowchart

```
Task is still in progress?
├── YES → Is context > 50%?
│          ├── YES → /compact (update AGENT.md first)
│          └── NO  → Keep going, monitor /context
└── NO (task committed) → ALWAYS start fresh session

Just switched to a new major task?
├── YES → Start fresh session (cleanest)
└── NO  → Continue or /compact

Agent giving weird/repeated answers?
├── YES → Start fresh session (context rot)
└── NO  → Continue

/context shows messages > 25%?
├── YES → Consider /compact if mid-task
└── NO  → Fine, keep going
```

---

## /compact Execution Protocol

Before running `/compact`, do these steps IN ORDER:

```
Step 1: Update context/AGENT.md
  - Update "Last commit" line
  - Tick off completed subtasks
  - Update "Next action" with exact next step

Step 2: Fill LAST SESSION HANDOFF block
  - Completed: [what was done this session]
  - Changed files: [2-3 key files]
  - Decision made: [any architecture choice]
  - Blocker/surprise: [anything unexpected]
  - Next action: [exact first step for continuation]

Step 3: Verify last commit exists
  - Run: git log --oneline -1
  - If nothing committed → commit first

Step 4: Run /compact
  - Claude compresses conversation history
  - Context resets but AGENT.md file persists

Step 5: After /compact, re-orient
  - Re-read AGENT.md (Claude will need to re-read it)
  - Confirm you're at the right state
  - Continue task
```

---

## Session Anti-Patterns

These are the behaviors that burn context fastest and degrade output quality:

### Anti-Pattern 1: The Context Dump
"Here's the whole codebase, understand everything before we start"
→ **Why it's bad:** Loads 20-50k tokens of stuff you won't need
→ **Fix:** Load only the 1-2 files relevant to THIS task

### Anti-Pattern 2: The Clarification Spiral
You give a vague task → agent asks 3 questions → you answer → agent asks 2 more → etc.
Each exchange = ~2-4k tokens. 10 exchanges = 20-40k tokens before any code is written.
→ **Why it's bad:** Wastes budget on setup instead of execution
→ **Fix:** Give the complete task description in ONE message. Include: what to build, which files, what success looks like, what to avoid.

### Anti-Pattern 3: The Everything Session
Trying to do QA + Security + Phase 3 + review all in one session
→ **Why it's bad:** By hour 2, context is noisy and agent quality degrades
→ **Fix:** One task per session. Commit. Fresh session.

### Anti-Pattern 4: The Safety Load
Loading AXIOM full skill (330 lines, ~8k tokens) at session start "just in case"
→ **Why it's bad:** Burns ~8k tokens for a skill you might not even use
→ **Fix:** Check SKILL_INDEX first, load only the module that matches THIS task

### Anti-Pattern 5: Re-reading Committed Files
"Read the current state of chat.service.js to understand it"
→ **Why it's bad:** If you just edited it, you know what's in it. Reading it adds ~2-5k tokens to context permanently.
→ **Fix:** Read a file only when you're about to edit it AND don't know its current state.

---

## Emergency Protocols

### "I hit the usage limit mid-task"
1. Commit whatever partial work exists with a clear message
2. Update AGENT.md LAST SESSION HANDOFF with exact state
3. Note the time limit will reset (usually daily)
4. Tomorrow: fresh session → read AGENT.md → pick up from handoff

### "Agent started repeating itself / seems confused"
1. Don't keep prompting → you're wasting limit
2. Update AGENT.md with current state
3. Start fresh session → brief it properly → continue

### "I accidentally loaded a huge file and context jumped"
1. No way to un-load it from current session
2. If critical work hasn't been committed → finish and commit
3. Then start fresh session to clear the noise
