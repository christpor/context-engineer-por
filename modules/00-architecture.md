## CONTEXT SIZE LAWS — Proven from Real Testing

| File | Hard Max | Sweet Spot | Why |
|------|----------|------------|-----|
| Router File | 50 lines | 40–50 lines | Auto-loaded every session — AI ignores middle past 50 |
| `context/AGENT.md` | 100 lines | 75–90 lines | Session brain — model misses instructions past 100 lines |
| `context/SKILL_INDEX.md` | 120 lines | 80–100 lines | Routing only — bloat = wrong skill loaded |
| `context/LAWS.md` | No limit | — | Reference only, never auto-loaded |
| `context/CONTEXT_ENGINEERING.md` | No limit | — | Reference only |

**Context rot is real** (industry term — Anthropic): as token count climbs, the model's ability to
accurately recall and reason **decays**. It's a *gradient, not a cliff* — quality erodes smoothly,
so you won't get an error, you'll just get worse answers without noticing. Cause: the transformer's
n² attention means every token dilutes every other. 2026 production data: reliable reasoning degrades
meaningfully **above ~50% of a model's advertised window**, well before the hard limit.

**Proof from my own testing:** a 258-line AGENT.md caused an agent to miss instructions in the middle
("lost in the middle"). Trimming to 81 lines fixed it immediately. The line limits above aren't
arbitrary — they're where rot started biting in practice.

**The split rule:** If any section in AGENT.md exceeds 3 lines of detail → move it to LAWS.md
with a one-liner pointer. AGENT.md holds the WHAT. LAWS.md holds the HOW and WHY.

---

## Why 3 Layers, Not 5

Research suggests a 5-layer model (Global Identity → Task Routing → Stage Contracts →
Reference → Working Artifacts). For solo developers, this is over-engineering.

- **Stage Contracts** (researcher.agent.md, coder.agent.md) → for multi-agent pipelines only
- **Working Artifacts** (Layer 4) → your actual code files, not context files
- **Task Routing** → already handled by SKILL_INDEX.md

**Use 5 layers** if you're building a multi-agent system with specialized roles.
**Use 3 layers** if you're a solo developer with one AI agent. Proven. Leaner. Faster.

---

## Mental Model — 3 Kinds of Memory (so you know what goes where)

Borrowed from cognitive science (Tulving) and how 2026 agent systems actually store state. Your
3 layers already map onto these — naming them stops you from dumping the wrong thing in the wrong file:

| Memory type | Holds | Lives in |
|-------------|-------|----------|
| **Episodic** — what *happened* | Past sessions, bugs, failure modes, decisions-in-time | `.learnings/errors/`, handoff blocks |
| **Semantic** — what's *true* | Project facts, conventions, current state, who the dev is | `AGENT.md` (and `LAWS.md` for deep facts) |
| **Procedural** — *how* to act | Behaviors, workflows, tool-use patterns | this `SKILL.md` + skill modules |

**Recency tiers (2026 production memory):** keep recent context verbatim, compress old. Hot = live
session · Warm = recent sessions (handoff summary) · Cold = older (rolled into LAWS.md as patterns).
Store the *distilled lesson*, drop the raw transcript — that's why LAWS.md grows slowly over months.
