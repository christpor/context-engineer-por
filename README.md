# Context Engineer Por — Production AI Context Engineering OS

An elite context engineering OS for production AI projects. Works universally out-of-the-box with **Antigravity CLI**, **Claude Code**, **Cursor**, **GitHub Copilot**, **Windsurf**, and **Codex/OpenAI CLI**.

It enforces a strict 3-layer architecture, combats context rot, and completely isolates its modules to prevent hallucinations.

---

## 🚀 How to Deploy / Install

You have two ways to deploy this skill depending on your workflow:

### 1. Global Installation (Best for Antigravity CLI / Gemini CLI)
If you want this skill available automatically in *every* project on your computer:

1. Open your terminal in this directory.
2. Run the installer script:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```
This will copy the skill to your global `~/.gemini/config/skills/` directory.

### 2. Project-Specific Installation (Best for Cursor, Claude Code, Windsurf)
If you are moving this to another computer or want it embedded inside a specific repository:

1. Create a skills folder in your project root:
   ```bash
   mkdir -p .agents/skills
   ```
2. Copy this entire `context-engineer-christ` folder into it:
   ```bash
   cp -r /path/to/context-engineer-por .agents/skills/
   ```

---

## ⚡ How to Use

Once deployed, you don't need to do anything complex. Just open your AI terminal or IDE and say:

> *"Please set up the context architecture for this project using the context-engineer-christ skill."*

The agent will automatically discover the `SKILL.md` file, run the **Phase 0 Silent Audit**, and begin generating your `AGENTS.md`, `SKILL_INDEX.md`, and `.learnings/errors/` directories based on the rules.
