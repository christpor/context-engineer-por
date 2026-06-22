# Subagent 4 Result — Module 4: Amnesia Test

## Test Prompt
"Here's my AGENT.md — it has branch name and last commit but the next task just says 'work on Phase 3'. There's no LAST SESSION HANDOFF block anywhere. Run the Amnesia Test on it and tell me exactly what to fix."

## Full Response (what the skill produced)

**Routing: Module 4 — Amnesia Test + Fix**

You gave me an AGENT.md. Running the Amnesia Test now. Two immediate failures — here's the full scan:

---

### Amnesia Test Results

```
[x] Branch name — readable with zero context?          ✅ PASS (you said it's there)
[x] Last commit hash + description — present?          ✅ PASS (you said it's there)
[ ] What's been built — exhaustive list, checkboxes?   ❓ Not mentioned — assume missing
[ ] Next task — EXACT steps?                           ❌ FAIL — "work on Phase 3" is vague
[ ] Key file paths — the 5-8 files touched most?       ❓ Not mentioned — assume missing
[ ] Architecture laws that matter RIGHT NOW?           ❓ Not mentioned — assume missing
[ ] Fresh chat guide — exactly how to start?           ❓ Not mentioned — assume missing
[ ] Which skill for which task via SKILL_INDEX?        ❓ Not mentioned — assume missing
[ ] LAST SESSION HANDOFF block — filled in?            ❌ FAIL — explicitly missing
```

**Hard failures: 2 confirmed. Fix these first — they're the most dangerous.**

---

### Fix 1 — Kill "work on Phase 3"

"Work on Phase 3" fails the Amnesia Test immediately. A fresh agent reads that and has zero idea what to build, which file to open first, or what done looks like. This is not a task — it's a label.

**Replace it with this format:**

```markdown
## Next Task
**Phase 3 — [Specific Feature Name]**

Step 1: Open `server/src/modules/[module]/[file].js` — add [specific function/endpoint]
Step 2: Wire it to `[route file]` at POST /api/[specific-endpoint]
Step 3: Test with [specific input] → expect [specific output]
Step 4: Update `client/src/[component].jsx` to call the new endpoint
Step 5: Commit with message: "feat([scope]): [what it does]"
```

Fill in the brackets with your actual Phase 3 specifics. If you don't know what Phase 3 actually means right now, that's the real problem — clarify that before you close this session, not after.

---

### Fix 2 — Add the LAST SESSION HANDOFF block

This block is what makes the next session start in 30 seconds instead of 10 minutes. It must exist in `context/AGENT.md` before you close any session.

**Add this block at the bottom of your AGENT.md right now:**

```markdown
## LAST SESSION HANDOFF (update before every session end)
- Completed: [what you finished this session + commit hash]
- Changed files: [2-3 key files you touched, e.g. chat.controller.js, ChatWidget.jsx]
- Decision made: [any architecture choice, or "none"]
- Blocker/surprise: [anything unexpected, or "none"]
- Next action: [exact first step for next session + model to use + skill to load]
```

**Filled-in example for a Phase 3 context:**

```markdown
## LAST SESSION HANDOFF
- Completed: Phase 2 final QA — all vision upload flows verified (commit a4f2c91)
- Changed files: chat.service.js, farmerProblem.model.js, ChatWidget.jsx
- Decision made: Semantic cache TTL set to 24h for price queries
- Blocker/surprise: none
- Next action: Phase 3 — start with POST /api/chat/market-prices in chat.controller.js,
               use Sonnet 4.6, no extra skill load needed
```

---

### What to do right now (in order)

1. Rewrite "work on Phase 3" → specific file + endpoint + test case steps (Fix 1 above)
2. Add the LAST SESSION HANDOFF block at the bottom of AGENT.md (Fix 2 above)
3. Run the full Amnesia Test checklist again — verify all 9 boxes pass before you close

Don't rewrite the whole AGENT.md. Fix only the two failing fields. The Amnesia Test is surgical — it tells you exactly what's broken, you fix exactly that.

The test passes when a fresh agent can open the terminal, read your AGENT.md, and start building Phase 3 without asking you a single question.

---

## Pass/Fail Per Criterion

- Identified vague task as failing: PASS
- Identified missing LAST SESSION HANDOFF: PASS
- Gave specific actionable fix: PASS
- Routed via Module 4: PASS
- Response is actionable not theoretical: PASS

## Overall: PASS — The response ran a full Amnesia Test checklist, flagged both confirmed failures with specific line-level fixes including exact replacement text, and told the user precisely what to do and in what order without any filler.
