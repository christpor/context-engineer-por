## Module 6 — Skill Index Engineering

The SKILL_INDEX.md is a routing file, not a skill library.

**Why a tight index beats a big one (Anthropic):** *"If a human engineer can't definitively say which
tool should be used in a given situation, an AI agent can't be expected to do better."* A bloated,
overlapping skill list makes the agent pick wrong. Each row must map cleanly to one task with no overlap.

### Rules
1. **Verified only** — never add a skill you haven't read and tested on a real task
2. **Task-based rows** — agent looks up task → gets skill path; no two rows should compete for the same task
3. **Your skills path** — store the absolute path to your skills folder in AGENT.md once,
   reference it as `[YOUR_SKILLS_PATH]` in SKILL_INDEX. Never hardcode machine paths in skills.
4. **Load ONE module only** — never the full skill (token waste)
5. **Trim ruthlessly** — untested or overlapping skills removed immediately

### Template
```markdown
# SKILL_INDEX.md — [Project] Skill Router
> Read BEFORE any task. Pick ONE skill. Load only that path.

## TASK → SKILL MAP
| Task | Skill to Load |
|------|--------------|

## MANUAL SKILLS (load one module only)
| Skill | Use When | Path |

## BUILT-IN COMMANDS (tool-specific, no load needed)
| Command | Use When | Tool |
Note: these vary by tool — check your tool's command palette for equivalents
```
