# Reference 01 — Context Architecture Audit Protocol
> Load this when auditing an EXISTING project's context setup.
> Run the full checklist → assign a health score → fix in priority order.

---

## The 10-Point Context Health Audit

Score 1 point for each YES. 0 for NO or PARTIAL.

### Layer 1 — Entry Point
- [ ] `CLAUDE.md` exists in project root?
- [ ] `CLAUDE.md` is under 50 lines?
- [ ] `CLAUDE.md` auto-reads in under 5 seconds (no unnecessary detail)?

### Layer 2 — Brain
- [ ] `context/AGENT.md` exists?
- [ ] Passes the full 9-point Amnesia Test (see SKILL.md Module 4)?
- [ ] LAST SESSION HANDOFF block is filled (not empty template)?

### Layer 3 — Reference
- [ ] `context/LAWS.md` or equivalent deep reference exists?

### Protection
- [ ] `context/` and `CLAUDE.md` are in `.gitignore`?
- [ ] No private paths, tokens, or credentials in any context file?

### Skill Routing
- [ ] `context/SKILL_INDEX.md` exists with verified skills only?

---

## Health Score Interpretation

| Score | Status | Action |
|-------|--------|--------|
| 9–10 | Healthy | Minor tune-ups only |
| 7–8 | Good | Fix the 2-3 failing checks |
| 5–6 | At Risk | Context bloat likely — rebuild weak layers |
| 3–4 | Broken | Agent will re-ask questions constantly — full rebuild |
| 0–2 | No system | Build from scratch using Module 1 |

---

## Red Flags (Immediate Fix Required)

**Red Flag 1: CLAUDE.md is too long**
- Symptom: CLAUDE.md > 100 lines, contains architecture laws, commit history, full rules
- Risk: ~3k+ tokens burned every session before work starts
- Fix: Move everything except entry-point instructions to AGENT.md or LAWS.md

**Red Flag 2: AGENT.md has vague tasks**
- Symptom: Tasks say "work on QA stuff" or "fix the bugs" — no file names, no endpoints
- Risk: Fresh agent wastes 5-10 exchanges asking what to do
- Fix: Rewrite each task with exact steps: file path + endpoint + test case + success criteria

**Red Flag 3: No gitignore protection**
- Symptom: `git status` shows `context/AGENT.md` as staged or tracked
- Risk: Private workflow files, local paths, API strategy pushed to team repo
- Fix: Add `context/` and `CLAUDE.md` to `.gitignore` immediately

**Red Flag 4: Skills loaded at session start**
- Symptom: CLAUDE.md says "Load AXIOM skill" as Step 2 before any task
- Risk: ~8k tokens burned reading a skill you may not need
- Fix: Change to "Read SKILL_INDEX before any task → pick ONE skill → load it"

**Red Flag 5: LAST SESSION HANDOFF is empty**
- Symptom: Block exists but has placeholder text like "[what was done]"
- Risk: Fresh agent tomorrow has no compressed handoff → re-explains everything
- Fix: Fill it in RIGHT NOW before closing the session

**Red Flag 6: Community skills in SKILL_INDEX (unverified)**
- Symptom: SKILL_INDEX has 10+ skills added by name/description only, never tested
- Risk: Wrong skill loaded for task → bad guidance on production code
- Fix: Trim to verified skills only. Add back after testing each one on a real task.

---

## Fix Priority Order

If audit score is low, fix in this order:

1. **gitignore** — protect private files first (5 min)
2. **CLAUDE.md size** — slim it down if > 50 lines (10 min)
3. **AGENT.md tasks** — make next tasks specific with exact steps (15 min)
4. **LAST SESSION HANDOFF** — fill it in (5 min)
5. **SKILL_INDEX** — trim unverified skills (10 min)
6. **LAWS.md** — create if missing, move deep content from AGENT.md (20 min)

Total: ~65 minutes to go from broken → healthy context architecture.

---

## Audit Output Template

After running the audit, report to Christpor in this format:

```
Context Health Score: X/10

What's working:
- [item] ✅

What needs fixing:
- [item] → [specific fix, estimated time]

Priority fix: [the most critical one]
```

Keep it under 15 lines. Don't dump the full checklist — just the actionable delta.
