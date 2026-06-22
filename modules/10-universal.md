## Module 10 — Two Universal Principles (apply everywhere)

**Just-in-time retrieval** (Anthropic): keep *lightweight identifiers* — file paths, queries, links —
and load actual content **only when the task needs it**, like a human who knows where to look instead of
memorizing the codebase. This is *why* the rule is "read only the file you're about to edit," and why
Router/AGENT files point to detail rather than inlining it. Pre-loading burns budget and speeds context rot.

**Verify before done**: never report complete without (a) running/testing it and (b) updating CURRENT
STATE. "It should work" ≠ "it works." Claiming done on untested code poisons the next session's trust in
AGENT.md — and a context system runs entirely on that trust.
