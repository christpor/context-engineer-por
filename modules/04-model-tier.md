## Module 4 — Model Tier Routing

**Never hardcode model names in context files, modules, or skills.** Model names change every
6 months; capabilities don't. Route by tier, resolve tier → current model in ONE place:
`references/00-model-profiles.md` (the only file allowed to hold names, IDs, windows, prices).

### The 3 Tiers

- **Tier 1 — Micro/programmatic:** the smallest, cheapest entry in the provider's lineup.
  For production app code calling a model API — never as your terminal driver.
- **Tier 2 — Daily Driver (80–90% of all work):** fast, cost-efficient, strong at code and
  mechanical tasks. Always start here.
- **Tier 3 — Frontier (escalation only):** highest capability, 3–5× Tier 2 cost, sometimes a
  fast-burn quota drain. Switch ONLY after Tier 2 failed the same task twice, or for security
  audits / pre-merge reviews / multi-service architecture. Full decision table + escalation
  protocol: `references/03-model-routing.md`.

### On session start
1. Look up your current model in `references/00-model-profiles.md` (add a row if missing —
   from provider docs, never from memory).
2. Note its burn rate and set your checkpoint instrument to the row's token-limit.
3. Note its cache TTL — batch prompts inside one TTL window.

Names drift. Tiers don't. Verify rows older than 90 days at provider docs.
