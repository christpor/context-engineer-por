# Reference 03 — Model Routing (tier-based, model-agnostic)
> Load this when deciding which model to use for a task.
> No model names live here — resolve tiers against `references/00-model-profiles.md`.

---

## The Core Rule

Route 80–90% of work to **Tier 2** (daily driver) by default.
Escalate to **Tier 3** (frontier) ONLY when cognitive stakes are genuinely high.
Never escalate just because context is full — that's a session problem, not a model problem.

---

## Decision Table (by tier)

| Task Type | Tier | Why |
|-----------|------|-----|
| Writing feature code (controllers, services, models) | 2 | Strong code, fast, cheap |
| Fixing a specific bug with known cause | 2 | Mechanical execution |
| Writing tests / QA scripts | 2 | Formulaic work |
| DB models, cron jobs, middleware, configs | 2 | Pattern-following |
| Reading and editing specific files, session admin | 2 | No deep reasoning needed |
| Security audit (prompt injection, rate limits, sandbox) | 3 | Must find edge cases humans miss |
| Pre-merge final review (multi-file, CTO-level) | 3 | High-stakes deep reasoning |
| Architecture decision across 5+ files, new multi-service design | 3 | Synthesis of many concerns |
| Bug Tier 2 couldn't crack after 2 attempts | 3 | Escalate on proven failure only |
| Production app code calling a model API programmatically | 1 | Cheapest that passes your evals |

---

## The Frontier Trap (Common Mistake)

**Wrong reasons to escalate to Tier 3:**
- "Context is at 40% and I'm stuck" → session management issue: compact or fresh session.
- "I want the best possible answer" → Tier 2 is excellent for 90% of tasks.
- "This is important" → importance ≠ complexity. Important + mechanical = still Tier 2.

**Right reasons:** the task genuinely needs deep reasoning, synthesis, or subtle edge-case
detection — security audits, complex architecture, final pre-merge reviews.

**Escalation protocol:** switch model → open a FRESH session (never carry the old context
into the expensive model) → do the high-stakes task → commit → switch back → fresh session.

---

## Daily Usage Limit Strategy

You have a finite daily/subscription budget across all tiers combined. The ratio, not the
absolute number, is what matters: Tier 3 costs roughly **3–5× more per exchange** than
Tier 2 (check the cost-tier and burn-rate columns in the profile table for your models).

**If you're near the limit mid-day:**
1. Remaining work mechanical? → Tier 2, conserve Tier 3 budget.
2. Remaining work a critical quality gate? → Spend Tier 3, it's worth it.
3. Otherwise: commit everything done, update the Agent Brain handoff, end for the day.

**Fast-burn models:** some frontier models drain quota several times faster per exchange
(see the burn-rate column). On those, set your checkpoint instrument to the LOWER
token-limit from the profile table at session start — turn counts alone under-report burn.

---

## Appendix — Harness Cheatsheet (example-only, dated; IDs live in the profile table)

Claude Code: `/model <id-from-profile-table>` switches models; open a fresh terminal after.
API calls (when BUILDING an app, not in a coding harness): set the reasoning knob listed
in the profile table's Knobs column (e.g. `effort` on Anthropic frontier models) — `low`
for simple tasks to save tokens, `high` for audits/architecture. Verify current parameter
names at provider docs before shipping; they drift.
