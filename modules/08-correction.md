## Module 8 — Self-Correction & Proactive Safety

Two jobs: (1) prevent repeating past mistakes, (2) write structured error files when new ones happen.
The critical upgrade: scan BEFORE acting, not just after failing.

---

### Proactive Scan — BEFORE Executing (not just after mistakes)

Run this mental checklist before any task that touches infra, deployment, billing, auth, or data:

```
BEFORE EXECUTING:
1. ls .learnings/errors/ — read anything relevant to today's task domain
2. Is the skill I'm about to follow complete? (→ Module 11 quick audit)
   - Does it have a cost section? (if infra/deploy)
   - Does it have rollback? (if deploy/data)
   - Does it have post-action verification? (if infra/deploy)
3. If the skill is missing a mandatory section → FLAG IT to the user
   before executing. Do not blindly follow an incomplete skill.
```

**The rule:** A missing section in a skill is a risk signal, not "someone else's problem."
If you notice it, you own flagging it. Tonight's $5 billing surprise happened because an
agent followed a deployment skill that had no cost section — and didn't question it.

---

### When to write an error file

- Any bug that cost more than 15 minutes to debug
- Any mistake that repeated from a previous session
- Any wrong assumption that broke something
- **NEW: Any skill gap that caused an incident** (missing section, wrong default, no verification step)

### Setup
```bash
mkdir -p .learnings/errors
```
Add `.learnings/` to `.gitignore` — these are local lessons, not shared.

### File naming
`YYYY-MM-DD-[short-slug].md`
Example: `2026-08-24-cloud-run-min-instances-billing-surprise.md`

### Template
```markdown
## Error: [what went wrong — 1 line]
## Root Cause: [why it happened — be specific: which skill/doc was missing what]
## Prevention: [exact rule — specific file + line if possible]
## Skill Gap: [which skill needs updating, and what section to add]
## Time lost: [estimate]
```

### Scan rule (add to SESSION START step in AGENT.md)
```
Before loading any skill:
  ls .learnings/errors/
  Read any file newer than last commit date
  If today's task domain matches a past error → apply the prevention rule
```

### Before retrying — check durable state first
A failed step doesn't mean start over. Redoing finished work from scratch is pure token waste.
Before re-running anything: check what already exists.
```
[ ] Did the task write any files already? → read them, don't regenerate
[ ] Is there a partial commit or log from the failed attempt? → resume from there
[ ] Retry the exact same thing at most once — if it fails twice, the plan is wrong, not the attempt
```
Only redo the piece that's actually missing or broken — never the whole task.

### Successful workflow → capture it, don't just log failures
After a task that took real multi-step problem-solving and worked — ask "is this reusable?"
If yes and no skill covers it yet, route to `skill-creator` to save it.

### Promotion rule — count occurrences, don't guess
- **1 occurrence** = a logged incident. Leave it in `.learnings/`.
- **2 occurrences** = a *pattern*. Write the prevention rule sharply.
- **3+ occurrences** = promote to AGENT.md HARD LESSONS or LAWS.md permanently.

### Skill-gap escalation (NEW)
When an error's root cause is a **missing skill section** (not a code bug):
1. Log the error normally
2. Run Module 11 (Skill Integrity Checklist) on the deficient skill
3. Add the missing section immediately — don't wait for the next incident
4. Note in the learning log which skill was updated and what was added
