# Subagent 5 Result — Module 5: Skill Index Repair

## Test Prompt
My SKILL_INDEX.md has 15 skills listed from a community pack I added. I've never actually tested any of them on a real task. I just added them because they sounded relevant. What should I do and how do I fix it?

## Full Response (what the skill produced)

**Routing: Module 5 — Skill Index Engineering**

Bro, your SKILL_INDEX.md is broken right now. 15 untested skills is not a "starter index" — it's a liability. Here's what's actually happening and how to fix it.

---

### The Risk (why this matters now)

Your SKILL_INDEX.md is the file your agent reads BEFORE every build task to decide which skill to load. If it lists 15 skills you've never read or tested, one of three things happens when the agent follows it:

1. It loads a skill with guidance that conflicts with your project's architecture — and silently applies wrong patterns to production code.
2. It picks the wrong skill for the task because the description sounded relevant but the actual module routing inside is completely different from what you expected.
3. It wastes context budget loading a full skill file that has zero signal for your current task.

Untested skills in a SKILL_INDEX are worse than no skill at all. At least with no entry, the agent falls back to general reasoning. With a wrong skill, it follows confident-sounding bad instructions.

---

### The Fix — 3 Steps

**Step 1: Audit all 15 entries — today, before your next build session.**

For each skill listed, open the actual SKILL.md file and read it fully. Not the name. Not the description line. The full file. Answer these questions for each:

- Does this skill's Module Router match task types I actually do in this project?
- Have I run this skill on at least one real task and seen it produce correct output?
- Does the skill's output contract match what my project needs?

If the answer to any of those is NO — remove it from SKILL_INDEX.md immediately.

**Step 2: Trim to verified-only.**

The rule from this system is non-negotiable:

> Never add a skill you haven't read fully AND tested on a real task. Name + 1-line description is not enough.

After your audit, you will probably keep 2-4 skills. That is the correct number for most projects. A SKILL_INDEX with 15 entries that are all unverified is not comprehensive — it's noise that degrades every session.

**Step 3: Rebuild the index in the correct format.**

Your SKILL_INDEX.md should have exactly 3 sections:

```markdown
# SKILL_INDEX.md — [Project Name] Skill Router
> Read this BEFORE any build task. Pick ONE. Load only that path.

## TASK → SKILL MAP
| Your Task | Skill to Load |
|-----------|--------------|
| [task type] | [verified skill name] |

## MANUAL SKILLS
| Skill | Use When | Path |
|-------|----------|------|
| [only verified skills here] | [specific trigger] | [absolute path] |

## BUILT-IN COMMANDS
| Command | Use When |
|---------|----------|
| /code-review | Quick diff review |
| /security-review | Full security audit |
| /verify | Confirm fix works |
| /run | Start app, test manually |

## FOR THIS SPRINT — Which Skill Per Task
| Session | Task | Load This |
|---------|------|-----------|
```

Rows in TASK → SKILL MAP are **task types**, not skill names. The agent looks up what it needs to do, not what skills exist.

Use **absolute paths** for every skill — skills live in your Agents skills workspace and the path must be exact, not relative.

---

### The Verification Rule (before adding any skill going forward)

Before any skill goes into SKILL_INDEX.md:

1. Read the full SKILL.md — not just the frontmatter description
2. Run it on one real task from your actual project
3. Confirm the output matched what you needed
4. Only then add it, with the exact absolute path and a task-based trigger description

If you haven't done all three — it doesn't go in the index. Period.

---

### What to do right now

1. Open your SKILL_INDEX.md
2. Delete all 15 entries
3. Read each SKILL.md from the community pack — one at a time
4. For any skill you've already used successfully on a real task: add it back with an absolute path
5. For everything else: leave it out until you've tested it

Start your next build session with a lean, verified index — even if that means 0 manual skills and only the built-in slash commands. That is safer than 15 untested entries.

## Pass/Fail Per Criterion

- Recommends trimming to verified-only: PASS
- Explains the risk: PASS
- Gives the verification rule: PASS
- Routed via Module 5: PASS
- Direct and actionable: PASS

## Overall: PASS — Response routes correctly through Module 5, explains the concrete risk of wrong skill guidance on production code, gives the read-full + test-on-real-task verification rule, and delivers a step-by-step actionable fix with zero fluff.
