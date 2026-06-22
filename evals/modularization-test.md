Since your `AGENT.md` is over 100 lines, you need to follow the Trim Protocol to reduce its size:

1. Read the full file.
2. Identify bloat: look for long code blocks, detailed plans, bug logs, and lessons learned.
3. Move everything with > 3 lines of detail to `LAWS.md` with a one-line pointer. For example:
   - `- **Merge conflict plan** → full detail in \`LAWS.md\``
   - `- **Bug patterns** → see \`LAWS.md — BUG PATTERNS\` section`
4. Keep only the essential information: current state, next tasks, key files, run commands, and the last handoff.
5. Verify your trimming by running `wc -l context/AGENT.md`, which must show ≤ 100 lines.
