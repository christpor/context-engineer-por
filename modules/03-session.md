## Module 3 — Session Engineering

**The one rule:** One task per session → commit → close → fresh session.

### What you actually control vs what you don't
Hermes Agent (NousResearch) triggers compression off a real token counter its own
`ContextCompressor` class reads — a 50%-soft / 85%-hard split against a known window size.
**You don't have that instrument.** Claude Code's auto-compact fires on harness logic you
can't see or measure — don't write rules that pretend to control the trigger. The only layer
you actually own is **what goes into the summary** once compaction happens (yours via `/compact`,
or the harness's own automatic pass). So: no fake percentages. Use observable proxies instead —
message count getting long, a tool call about to return something huge, or the conversation
visibly switching phase. When one of those fires, apply the 4-phase structure below to whatever
you write next, manual or automatic.

### The 4-phase compression algorithm (what actually happens, not just "summarize")
1. **Prune** — strip large tool outputs first, no LLM call needed. Anything over ~200 chars of raw
   tool result → replace with `[Old tool output cleared to save context space]`. Cheapest win, do it first.
2. **Set boundaries** — protect a head (system prompt + first exchange) and a tail (last ~20 messages,
   token-budget based) untouched. Only the *middle* gets summarized. Never split a tool_call from its
   tool_result — align boundaries around the pair, not mid-pair.
3. **Summarize the middle** — structured output only, not prose: **Goal / Constraints / Progress
   (Done · In Progress · Blocked) / Key Decisions / Relevant Files / Next Steps / Critical Context**.
   Budget the summary at ~20% of the content it replaces (cap it — don't let the summary itself bloat).
4. **Reassemble** — protected head + structured summary + protected tail. That's the new active context.

### Iterative re-compression — never restart from scratch
On the *second* and later compressions, feed the **previous summary** back into the LLM with "update
this, don't regenerate it." This is how information survives multiple compaction passes instead of
degrading each time — accumulate, don't overwrite.

### Cache-aware ordering (ties to the Byte-Stable Caching rule)
Compression invalidates the cache for whatever region it touches — but the system-prompt breakpoint
should survive untouched, and a rolling window of the last few messages re-establishes caching within
1–2 turns. Practical rule: never let compression rewrite the system prompt / Router File region. Only
ever touch the middle.

### Compress Context vs Fresh Session
```
Compress (context visibly heavy, mid-task, can't commit yet) when:
  → You want to continue without losing momentum, and the 4-phase structure above applies

Start FRESH when:
  → Just committed a task — always do this (commit = save point)
  → Switching between major phases
  → Agent seems confused or repeating itself
```

### Verification (the check this module was missing)
A summary you can't measure is a summary you can't trust. After writing the Phase 3 summary,
save the original and the summary to two files and run:
```bash
python3 context-engineer-por/scripts/token_audit.py summary-check <original> <summary>
```
Exits 0 (PASS) if the summary is ≤20% of the original's word count, exit 1 (FAIL) otherwise —
scriptable, not a manual guess. (Quick manual version if you don't want to save files: `wc -w`.)

### Before Compressing — Non-Negotiable
1. Update CURRENT STATE in AGENT.md (latest commit hash)
2. Fill in LAST SESSION HANDOFF block
3. Confirm last commit exists
4. Then compress

### Burn-Rate Awareness (model-dependent — measure, don't assume)
Token burn is a property of the **model**, not the conversation. Two sessions with identical
turn counts can differ several-fold in quota drain. At session start, look up your model's
burn-rate class in `references/00-model-profiles.md` and set your checkpoint instrument to
that row's token-limit (in this lab: `first_mate.py checkpoint --token-limit N`; elsewhere any
chars/4 counter). Fast-burn model = lower limit = earlier handoff. If measured burn exceeds
the expectation two turns running, compact early — don't wait for the warning.

**Cache-window discipline:** the profile table lists each model's cache TTL. A gap between
prompts longer than the TTL means the next turn re-reads full context at full price. Batch
related prompts inside one TTL window; if you must think longer than the TTL, that's a signal
to commit and hand off rather than idle.

### Token Budget Awareness
Every session has a fixed overhead before you type anything — system prompt, tools,
Router File, AGENT.md, skill triggers. This varies by tool and model. Check your tool's
context window and usage indicator. Rule: keep fixed overhead under 10% of total window.

Variable cost you control:
- Read only the file you're about to edit — not "to understand"
- Load ONE skill module right before the task — never full skill at session start
- Give complete task in ONE message — no back-and-forth clarification rounds

### Anti-Patterns That Kill Sessions
- Reading large files "just to understand" → context waste
- Loading full skill at session start → token waste
- Multiple tasks per session → always one concern, one commit, then fresh
- Letting AGENT.md grow past 100 lines → agent starts missing things
