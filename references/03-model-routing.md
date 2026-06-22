# Reference 03 — Model Routing Table
> Load this when deciding which Claude model to use for a task.
> Verified against official docs 2026-06-17. Re-check at platform.claude.com before
> using model IDs in production API code — names and parameters drift.

---

## The Core Rule

Route 80-90% of work to Sonnet 4.6 by default.
Switch to Opus 4.8 ONLY when cognitive stakes are genuinely high.
Never switch just because context is full — that's the wrong reason and burns daily limits faster.

---

## Full Decision Table

| Task Type | Model | Why |
|-----------|-------|-----|
| Writing feature code (controllers, services, models) | Sonnet 4.6 | Strong code, fast, cheap |
| Fixing a specific bug with known cause | Sonnet 4.6 | Mechanical execution |
| Writing tests / QA scripts | Sonnet 4.6 | Formulaic work |
| Building DB models, cron jobs, middleware | Sonnet 4.6 | Pattern-following tasks |
| Reading and editing specific files | Sonnet 4.6 | No deep reasoning needed |
| Setting up folder structure, configs | Sonnet 4.6 | Mechanical |
| Session start / reading AGENT.md | Sonnet 4.6 | Administrative |
| Security audit (prompt injection, rate limits, upload sandbox) | Opus 4.8 | Needs to find edge cases humans miss |
| Pre-merge final review (multi-file, CTO-level) | Opus 4.8 | High-stakes, needs deep reasoning |
| Architecture decision across 5+ files | Opus 4.8 | Synthesis of many concerns |
| Bug that Sonnet couldn't crack after 2 attempts | Opus 4.8 | Escalate when Sonnet fails |
| Designing a new system from scratch (multi-service) | Opus 4.8 | Complex tradeoff analysis |
| Writing API code that calls Claude programmatically | Haiku 4.5 | When building an app, not for Claude Code |

---

## Real Examples From Baitorng

**Use Sonnet 4.6:**
- "Write the cropProfile.model.js Sequelize model" → Sonnet (pattern-following)
- "Add the 2AM agrometeo cron job to chat.service.js" → Sonnet (specific, bounded)
- "Fix the Khmer TTS sentence-splitting bug" → Sonnet (known file, specific bug)
- "Write the Phase 2 QA test script" → Sonnet (formulaic testing)
- "Read AGENT.md and tell me where we left off" → Sonnet (administrative)

**Use Opus 4.8:**
- "Security audit: check for prompt injection in chat.service.js" → Opus (needs to find subtle edge cases)
- "Pre-merge review: full CTO audit before PR to develop" → Opus (most critical quality gate)
- "Design the Expert Escalation system for Phase 4" → Opus (new multi-service architecture)
- "This SSE bug isn't resolving after 2 attempts, help" → Opus (escalate when Sonnet fails)

---

## How to Switch Models in Claude Code

```bash
/model claude-opus-4-8      # switch to Opus 4.8 (security/review sessions)
/model claude-sonnet-4-6    # switch back to Sonnet 4.6 (coding sessions)
/model claude-haiku-4-5-20251001  # Haiku (if needed for API cost testing)
```

**Switching protocol for security sessions:**
```
1. /model claude-opus-4-8
2. Open fresh terminal (don't carry Sonnet session into Opus)
3. Run security audit
4. Commit
5. /model claude-sonnet-4-6
6. Open fresh terminal for next coding session
```

---

## Opus 4.8 Effort Parameter (for API usage, not Claude Code)

When calling Opus 4.8 via API in your own applications:

```json
{
  "model": "claude-opus-4-8",
  "max_tokens": 8192,
  "thinking": { "type": "adaptive" },
  "effort": "high"
}
```

Effort levels: `"low"`, `"medium"`, `"high"` (high = default on Opus 4.8).
- Use `"low"` for simpler Opus tasks to save tokens
- Use `"high"` for security audits, architecture reviews, complex synthesis
- `budget_tokens` is DEPRECATED on Opus 4.6+ — use `effort` instead

**Note:** This is for when you're BUILDING an app that calls Claude's API.
In Claude Code terminal, you don't set these parameters — just use `/model`.

---

## The Opus Trap (Common Mistake)

**Wrong reason to switch to Opus:**
- "My context is at 40% and I'm stuck" → No. That's a session management issue, not a model issue. /compact or fresh session.
- "I want the best possible answer" → Sonnet 4.6 is excellent for 90% of tasks. Don't pay the Opus cost unnecessarily.
- "This is important work" → Importance ≠ complexity. Important + mechanical = still Sonnet.

**Right reason to switch to Opus:**
- The task genuinely requires deep reasoning, synthesis, or catching subtle edge cases
- Specifically: security audits, complex architectural decisions, final pre-merge reviews

---

## Daily Usage Limit Strategy

You have a finite daily token budget across Sonnet + Opus combined.

**If you're near the limit mid-day:**
1. Check: is remaining work mechanical? → Use Sonnet, conserve Opus
2. Is remaining work critical quality gate? → Spend Opus, it's worth it
3. Commit everything done, update AGENT.md, end for the day
4. Limit resets daily — tomorrow you're full again

**The math:** Using Opus costs roughly 3-5x more tokens per exchange than Sonnet.
Opus session for security audit (~50 exchanges) = ~150-250k tokens.
Sonnet session for same work = ~50-80k tokens.
Reserve Opus for when it actually matters.
