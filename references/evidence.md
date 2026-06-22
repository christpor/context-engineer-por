# Evidence Base — Real Sources for context-engineer-christ

> Loaded as-needed. This skill's core claims are grounded in current authoritative sources, not vibes.
> **Meta-rule:** sources age. Treat the *principles* as durable; re-check the *numbers and tool names*
> yearly. If a claim in SKILL.md can't point to a row here, it's an opinion — label it as one.
> Last verified: 2026-06-22.

## Citation map — which claim rests on which source

| Claim in SKILL.md | Source | Link |
|-------------------|--------|------|
| "Smallest set of high-signal tokens"; **context rot** (gradient not cliff, n² attention); right-altitude system prompts; tool discipline ("if a human can't say which tool, the agent can't"); compaction recipe (recall→precision, preserve decisions/bugs, discard tool noise); just-in-time retrieval via lightweight identifiers; sub-agents return 1–2k-token distilled summaries | Anthropic — *Effective context engineering for AI agents* | anthropic.com/engineering/effective-context-engineering-for-ai-agents |
| Memory tool (file-based persistence across sessions); compaction; clearing tool results deep in history | Anthropic — *Claude Cookbook: context engineering — memory, compaction, tool clearing* | platform.claude.com/cookbook |
| Compress at **60–70% of window** (not the hard limit); hot/warm/cold hierarchical memory tiers; reliable reasoning degrades above **~50% of advertised window**; preserve reasoning traces in summaries | *Agent Context Engineering 2026 — sliding windows, hierarchical summarization, memory offloading* | agentmarketcap.ai (2026-04-11) |
| ~**65% of agent failures = context drift / memory loss** (not model weakness); memory-offload cuts tokens ~90% at similar accuracy | *State of AI Agent Memory 2026* — Mem0 | mem0.ai/blog/state-of-ai-agent-memory-2026 |

## Key numbers (re-check yearly — these drift)
- **60–70%** of context window = compaction trigger point.
- **~50%** of advertised window = where complex-reasoning reliability starts dropping noticeably.
- **~65%** of production agent failures attributed to context/memory problems, not raw model capability.
- Sub-agent return summaries: **1,000–2,000 tokens** distilled per task.

## What we deliberately did NOT adopt (and why)
From a NotebookLM "Model Workspace Protocol" rewrite, rejected as academic over-engineering that
contradicts this skill's proven, leaner model:
- 5-layer hierarchy + file renames (Layer 0–4 / CONTEXT.md) → conflicts with the proven "3 layers, not 5."
- LaTeX refinement cycle, Observer/Simulator gates, `z_encoded`, Inductive/Transductive jargon → no
  operational value; violates "principles not names."
- Replacing line limits with raw token budgets → line limits are simpler and testable; kept them.
Harvested only 3 genuinely useful ideas from it: the Self-Healing Trigger, the memory taxonomy as a
mental model, and the 2/3-occurrence pattern threshold.
