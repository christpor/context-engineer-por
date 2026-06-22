# Eval Results — Iteration 2
**Date:** 2026-06-19 | **Tester:** Hermes (inline) | **Skill version:** updated 2026-06-19

## What changed from iteration 1
- Added Context Size Laws table with proven line limits
- Added Module 2 (Trim Protocol) — new module entirely
- Module numbering shifted: Session Engineering = Module 3, Model Routing = Module 4
- Model routing updated: Sonnet 4.6 as default, Opus only after 2 Sonnet failures
- Pointer format examples added to Trim Protocol
- Self-updating note with real validation data ($50 → near-zero)

## Eval Results

| Test | Description | Result | Notes |
|------|-------------|--------|-------|
| 1 | New project context setup | ✅ PASS | Module 1 unchanged, all 6 deliverables correct |
| 2 | Mid-task 40% context, no commit | ✅ PASS | Module 3, /compact correct, steps in order. Fixed module number in evals.json |
| 3 | Sonnet vs Opus for unit tests | ✅ PASS | Module 4, Sonnet recommended, reason clear. Fixed module number in evals.json |
| 4 | AGENT.md 180 lines, agent forgetting | ✅ PASS | Module 2 (new), trim logic correct, pointer format examples present |

## Assertion Results

| Assertion | Pass |
|-----------|------|
| CLAUDE.md ≤ 50 lines | ✅ |
| AGENT.md has all 9 sections | ✅ |
| SKILL_INDEX included in output | ✅ |
| .gitignore additions specified | ✅ |
| Routes Module 1 for new project | ✅ |
| /compact for mid-task (not fresh) | ✅ |
| Pre-compact steps in correct order | ✅ |
| Sonnet 4.6 recommended for tests | ✅ |
| Model routing explanation clear | ✅ |
| Module 2 trim routes correctly | ✅ |
| Pointer format example present | ✅ |
| wc -l verification step present | ✅ |

**Pass rate: 12/12 assertions = 100%**

## Bugs found and fixed this iteration
1. Module numbers in evals.json were stale after adding Trim Protocol as Module 2 — updated
2. Trim Protocol missing pointer format example — added during eval run
3. evals.json missing Test 4 (Trim Protocol) — added

## Qualitative notes
- Skill correctly routes 4 different real-world situations
- Tone stays direct throughout
- Context Size Laws table is the biggest new value — fresh agents now know line limits immediately
- Model routing is clearer: Sonnet-first is explicit, Opus trap is named

## Next iteration recommendations
- Add test for Amnesia Test (Module 5) 
- Add test for session ending / handoff (Module 7)
- Consider testing description triggering accuracy
