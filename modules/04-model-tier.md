## Module 4 — Model Tier Routing

**Never hardcode model names in your context files or skills.** Model names change every
6 months. Capabilities don't. Route by tier, then verify current names at provider docs.

### The 3 Tiers

**Tier 1 — Daily Driver (use for 80–90% of all work)**
- Characteristics: fast, cost-efficient, handles code and mechanical tasks well
- How to identify: usually labeled "flash", "mini", "lite", "sonnet", "4o" in provider lineup
- Use for: coding, file edits, bug fixes, QA, security fixes, DB models, architecture
- Default: always start here

**Tier 2 — Deep Reasoner (use sparingly)**
- Characteristics: highest capability, slower, more expensive (usually 3–5x Tier 1 cost)
- How to identify: usually labeled "opus", "pro", "max", "o1", "thinking", "preview"
- Use for: ONLY after Tier 1 failed the same task 2 times
- The trap: don't switch because the task "sounds important" — switch only on proven failure

**Tier 3 — Micro (never use in terminal)**
- Characteristics: smallest, cheapest
- How to identify: usually "haiku", "nano", "mini", smallest in provider lineup
- Use for: AI apps calling the model API programmatically in production code

### How to find current model names:
```
Anthropic: docs.anthropic.com/en/docs/about-claude/models
OpenAI:    platform.openai.com/docs/models
Google:    ai.google.dev/gemini-api/docs/models
Others:    check provider's official model page
```
Verify before starting any new project. Names drift. Tiers don't.
