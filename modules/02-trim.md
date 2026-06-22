## Module 2 — Trim Protocol

When a context file is over its limit, trim it — don't just add to it.

### AGENT.md over 100 lines:
1. Read the full file
2. Identify bloat: long code blocks, detailed plans, bug logs, lessons learned
3. Move everything with > 3 lines of detail → `LAWS.md` with a one-line pointer:
   - `- **Merge conflict plan** → full detail in \`LAWS.md\``
   - `- **Bug patterns** → see \`LAWS.md — BUG PATTERNS\` section`
4. Keep: current state, next tasks, key files, run commands, last handoff
5. Verify: `wc -l context/AGENT.md` must show ≤ 100

### Router File over 50 lines:
1. It should ONLY point to AGENT.md and SKILL_INDEX — nothing else
2. Every "how to do X" line → move to AGENT.md or delete
3. Verify: `wc -l [router-file]` must show ≤ 50

### Quick check (run this anytime):
```bash
wc -l [router-file] context/AGENT.md context/SKILL_INDEX.md
```
Over limit = fix before next task.
