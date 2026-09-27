## Module 12 — Epistemic Clone Vault & Universal Telemetry

> "A second brain that bloats is an amnesia factory. A second brain that partitions atomically is a personal AI clone engine."

The Epistemic Clone Vault solves the fundamental multi-agent tension: **how to maintain lifetime chronological memory across dozens of projects without rotting context windows.**

---

### 1. The 4-Tier Memory Topology

```
~/.agents/memory/ (or <vault>/.agents/memory/)
├── short_term/
│   └── current_sprint.md              ← Tier 0: Active Working Memory (≤ 100 lines)
├── TIMELINE.md                        ← Tier 1: Chronological Master Index (O(1) Date Lookup)
├── timeline/
│   └── YYYY/
│       └── MM/
│           └── YYYY-MM-DD.md          ← Tier 2: Atomic Daily Archives (Obsidian Graph)
└── epistemic_ledger.jsonl             ← Tier 3: Machine AI Clone Training Vectors
```

#### Tier 0: Active Working Memory (`short_term/current_sprint.md`)
- **Hard Line Budget:** Strictly ≤ 100 lines.
- **Scope:** Current active goals, blockers, and immediate tasks.
- **Rotation Rule:** When tasks complete or the file exceeds 80 lines, archive past achievements into Tier 2 (`timeline/YYYY/MM/YYYY-MM-DD.md`) and keep only active context in Tier 0.

#### Tier 1: Chronological Master Index (`TIMELINE.md`)
- **Format:** Single markdown table sorted newest to oldest.
- **Row Budget:** Exactly 1 row per active date. Never multiple rows per date.
- **Columns:** `| Date | Focus / Milestone | Key Outputs & Tools | Daily Log Link |`
- **Purpose:** Gives agents instant $O(1)$ temporal context lookup without loading hundreds of past daily logs.

#### Tier 2: Atomic Daily Archives (`timeline/YYYY/MM/YYYY-MM-DD.md`)
- **Format:** Modular daily log with Obsidian-compatible bi-directional `[[wikilinks]]`.
- **Sections:**
  - `## Daily Overview & Primary Focus`
  - `## Sessions & Workstreams` (Project links, TL;DR, Summary, Decisions, Next steps)
  - `## Epistemic Heuristics & Learnings`
- **Isolation:** Each day is a self-contained file. An agent inspecting historical work reads *only* that specific date.

#### Tier 3: AI Clone Training Ledger (`epistemic_ledger.jsonl`)
- **Format:** Append-only JSON Lines (`application/jsonl`).
- **Schema:**
  ```json
  {
    "id": "epistemic-YYYYMMDD-HHMMSS",
    "timestamp": "ISO-8601",
    "project": "project-slug",
    "actor": "user | agent-name",
    "category": "architecture | debug | business | toolchain",
    "primary_goal": "One sentence intent",
    "decision_tree": {
      "chosen": "What approach was picked",
      "rejected": ["Alternative 1", "Alternative 2"],
      "tradeoff_rationale": "Why chosen was superior"
    },
    "heuristics_learned": [
      "Concrete rule or constraint discovered"
    ],
    "sovereignty_score": 10
  }
  ```
- **Purpose:** Provides structured, high-signal fine-tuning / in-context retrieval data to train a sovereign AI clone that thinks and decides exactly like the developer.

---

### 2. Universal Telemetry CLI Protocol (`brain-log`)

When working across multiple git repositories (e.g. `generations-for-cambodia`, `kapi-deployment`, `barber-salon`), logging to the local repo alone isolates knowledge.

The `brain-log` binary provides zero-friction, cross-repo telemetry without dirtying local git working trees:

```bash
brain-log \
  --project "project-slug" \
  --tldr "One-line executive summary" \
  --shipped "Features, modules, or fixes delivered" \
  --inventions "Mental models, novel patterns, or architectures" \
  --truth "Hard pushback findings, trade-offs, or lessons learned"
```

#### Protocol Guarantees:
1. **Zero Working Tree Pollution:** Appends to the centralized second brain (`~/.agents/memory/`), leaving the current project repository completely clean.
2. **Sub-15ms Latency:** Native compiled or optimized Python/Bash script executing synchronously with zero UI overhead.
3. **Atomic Multi-Tier Sync:** In a single call, updates:
   - Tier 1 (`TIMELINE.md`)
   - Tier 2 (`timeline/YYYY/MM/YYYY-MM-DD.md`)
   - Tier 3 (`epistemic_ledger.jsonl`)

---

### 3. Agent Execution Standard

Every agent operating under `context-engineer-por` must:
1. Check `current_sprint.md` line count at session start (`wc -l`). If > 100 lines, trigger rotation.
2. Log critical architecture decisions immediately to `epistemic_ledger.jsonl`.
3. Invoke `brain-log` during the Session Handoff sequence (Module 7).
