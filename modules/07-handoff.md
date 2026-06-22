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
