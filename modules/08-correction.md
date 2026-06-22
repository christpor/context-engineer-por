## Module 8 — Self-Correction Log

When an AI agent makes a mistake → write a structured error file. Scan it before every task.
This closes the gap between "bug documented" and "bug prevented from repeating."

### Setup
```bash
mkdir -p .learnings/errors
```
Add `.learnings/` to `.gitignore` — these are local lessons, not shared.

### When to write a file
- Any bug that cost more than 15 minutes to debug
- Any mistake that repeated from a previous session
- Any wrong assumption that broke something

### File naming
`YYYY-MM-DD-[short-slug].md`
Example: `2026-06-19-jwt-decode-not-verify.md`

### Template
```markdown
## Error: [what went wrong — 1 line]
## Root Cause: [why it happened]
## Prevention: [exact rule — specific file + line if possible]
## Time lost: [estimate]
```

### Scan rule (add to SESSION START step in AGENT.md)
```
Before loading any skill:
  ls .learnings/errors/
  Read any file newer than last commit date
```

### Promotion rule — count occurrences, don't guess
Quantify before you promote (keeps LAWS.md signal-dense, not cluttered with one-offs):
- **1 occurrence** = a logged incident. Leave it in `.learnings/`.
- **2 occurrences** = a *pattern*. Write the prevention rule sharply.
- **3+ occurrences** = a *strong pattern*. Promote it to `LAWS.md` under HARD LESSONS, then delete the
  `.learnings` files. The rule now lives in LAWS.md permanently.

The point: a mistake that happened once might be luck; one that happened three times is a hole in your
process. Only the proven holes earn a permanent line in LAWS.md.
