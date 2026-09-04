# Reference 00 — Model Profile Table (THE single source of model-specific numbers)
> This is the ONLY file in this skill allowed to contain model names, IDs, windows, or prices.
> Modules and other references speak in tiers and ratios and resolve them HERE at use time.
> **If your model isn't listed: ADD A ROW from the provider's official docs — never guess
> from training data.** If `last-verified` is older than 90 days, re-verify before trusting.

| Model | ID | Provider | Window | Cache TTL | Cost tier | Burn rate | Checkpoint token-limit | Knobs | Last-verified |
|-------|----|----------|--------|-----------|-----------|-----------|------------------------|-------|---------------|
| Fable 5 | `claude-fable-5` | Anthropic | verify at docs | 5 min | 3 (frontier) | **fast** | `--token-limit 40000` | adaptive thinking | 2026-07-02 |
| Opus 4.8 | `claude-opus-4-8` | Anthropic | 200k | 5 min | 3 (frontier) | medium | `--token-limit 80000` | `effort: low/med/high` (budget_tokens deprecated) | 2026-07-02 |
| Sonnet (latest) | `claude-sonnet-5` | Anthropic | 200k–1M (verify) | 5 min | 2 (default) | medium | `--token-limit 100000` | standard | 2026-07-02 |
| Haiku 4.5 | `claude-haiku-4-5-20251001` | Anthropic | 200k | 5 min | 1 (cheap) | slow | n/a (API tier) | standard | 2026-07-02 |
| Gemini (agy CLI) | verify at docs | Google | ~1M | verify | 2 (default) | medium | `--token-limit 100000` | thinking budget | 2026-07-02 |

## Column meanings
- **Cost tier** — maps to the 3-tier router in `modules/04-model-tier.md`: 1 = cheap/programmatic,
  2 = daily driver, 3 = frontier (escalation only).
- **Burn rate** — how fast the model drains a subscription/daily quota per exchange, relative to
  tier-2. `fast` = set the LOWER checkpoint limit at session start; turn count alone lies.
- **Checkpoint token-limit** — the value to pass to your per-turn counter instrument
  (`first_mate.py checkpoint --token-limit N` in this lab; any chars/4 counter elsewhere).
- **Cache TTL** — max gap between prompts before the prompt cache goes cold and the next turn
  re-reads full context at full price. Batch work inside one TTL window.

## Maintenance rule
New model release = add ONE row here. Zero edits anywhere else in this skill.
Staleness is instrument-checked, not honor-system: `scripts/token_audit.py profile-check`
exits 1 on rows older than 90 days, and `first_mate.py gate` surfaces it before every commit.
Verify at: Anthropic `platform.claude.com/docs` · Google `ai.google.dev` · OpenAI `platform.openai.com/docs`.
