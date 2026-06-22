# Subagent 2 Result — Module 2: Session Bloat Mid-Task

## Test Prompt
I'm in the middle of writing a security audit fix. Context is at 40%. I haven't committed yet. What exactly do I do right now?

## Full Response (what the skill produced)

**Module 2 — Mid-Task, No Commit, 40% Context**

You're mid-task, no commit yet, 40% context. Do NOT start fresh. Run `/compact`. Here's the exact order:

**Step 1 — Update `context/AGENT.md` CURRENT STATE section**
Write exactly where you are in the security audit fix: what you've touched, what's left, what decisions you've made so far.

**Step 2 — Fill in the LAST SESSION HANDOFF block**
```
## LAST SESSION HANDOFF
- Completed: [nothing yet — security audit fix in progress]
- Changed files: [list the files you've modified so far]
- Decision made: [any security decision made, or "none yet"]
- Blocker/surprise: [anything unexpected, or "none"]
- Next action: [exact next step when you resume — specific file + what to do]
```

**Step 3 — Run `/compact`**
This compresses the session without losing your work state. You stay in the same session with a smaller token footprint and keep full momentum.

Do NOT open a fresh session — that wipes in-session state and you'll waste time re-loading context you already have.

---

## Pass/Fail Per Criterion

- Recommends /compact not fresh session: PASS
- Steps in correct order (update AGENT.md → fill handoff → /compact): PASS
- Does NOT say start fresh: PASS
- Under 20 lines: PASS
- Routed via Module 2: PASS

## Overall: PASS — Response correctly routes to Module 2, recommends /compact over fresh session, delivers steps in the exact order specified by the skill, and stays well under 20 lines.
