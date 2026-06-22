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
