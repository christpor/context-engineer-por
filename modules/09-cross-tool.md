## Module 9 — Cross-Tool Router Handoff

When you switch AI tools mid-project (e.g. hit a usage limit on one, continue on another), the new tool
**won't auto-read the old tool's Router File** — each tool only loads its own (Claude→`CLAUDE.md`,
Antigravity/Gemini→`GEMINI.md` or `AGENTS.md`, Cursor→`.cursorrules`). Without its own router, the new
agent skips your boot protocol and starts winging it.

**The fix — generate a sibling router (5 minutes, never duplicate context):**
1. Copy the existing router → rename to the new tool's filename (see Universal Vocabulary table in SKILL.md).
2. Keep it a **pure pointer** — same steps: read AGENT.md → read SKILL_INDEX → git check → wait for GO.
   **Do NOT** copy project state into it. `AGENT.md` stays the single source of truth across all tools.
3. Adapt only the **tool-specific lines**: the compress command (`/compact` vs "New chat"), and the
   model tier note (which model is the daily driver on that tool).
4. Carry the **Self-Healing Trigger** and the **Core Law / token discipline** into it.
5. **Gitignore it** alongside the other router files — routers are local, never pushed.

Result: open the project in any tool → its router routes it into the same AGENT.md → it boots with the
same brain and the same cost rules. The thing that keeps both tools sharp is one current AGENT.md.
