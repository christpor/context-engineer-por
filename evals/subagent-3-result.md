# Subagent 3 Result — Module 3: Model Routing

## Test Prompt
I need to write unit tests for my Node.js upload endpoint AND do a full security audit of the same endpoint. Which model for each task and why?

## Full Response (what the skill produced)

Two different tasks, two different models.

**Unit tests → Sonnet 4.6**
Writing tests is formulaic work — you're pattern-matching against a known endpoint structure, generating assertions, mocking dependencies. Sonnet handles this fast and cheap. No deep reasoning required.

```bash
/model claude-sonnet-4-6
```

**Security audit → Opus 4.8**
A security audit on an upload endpoint requires finding subtle edge cases: path traversal, MIME type spoofing, oversized payloads bypassing limits, prompt injection if filenames hit AI logic, missing sandbox isolation. Opus is built for this — it synthesizes across concerns and catches what humans (and Sonnet) miss. This is exactly the cognitive-stakes threshold that justifies the switch.

```bash
/model claude-opus-4-8
```

**Protocol:** Do them in separate sessions. Write tests with Sonnet → commit → fresh terminal → switch to Opus for the audit → commit → switch back.

## Pass/Fail Per Criterion
- Sonnet 4.6 for unit tests: PASS
- Opus 4.8 for security audit: PASS
- /model commands given: PASS
- WHY explained for each: PASS
- Under 20 lines: PASS

## Overall: PASS — All five criteria met: correct model routing with clear mechanical vs. deep-reasoning justification, both /model commands provided, and response is well under 20 lines.
