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
