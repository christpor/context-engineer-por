## Module 11 — Skill Integrity Checklist

When creating or updating a skill that touches infrastructure, billing, authentication,
data, or deployment — run this checklist. A skill missing mandatory sections for its
domain is a latent incident waiting to fire (see: 2026-08-24 billing surprise from
`kapi-deployment` missing cost controls).

---

### When to Run This

| Trigger | Action |
|---------|--------|
| Creating a new skill via `skill-creator` or `manus-creator` | Run checklist before packaging |
| Updating a skill that touches infra/billing/auth/deploy | Verify mandatory sections still present |
| Post-incident review (billing surprise, security gap, data loss) | Audit the skill that governed the failed action |
| Audit protocol (Reference 01) flags a project at risk | Check skill index for coverage gaps |

---

### Domain Classification

First, classify what the skill touches. A skill can touch multiple domains.

| Domain | Examples | Mandatory Sections Required |
|--------|----------|----------------------------|
| **Infrastructure** | Cloud Run, AWS Lambda, Kubernetes, VMs, serverless | Cost, Scaling, Rollback |
| **Billing / Cost** | API usage, compute allocation, storage, model calls | Budget ceiling, Free-tier math, Stage-gate |
| **Authentication / Security** | OAuth, API keys, tokens, RBAC, Firestore rules | Threat model, Rotation plan, Audit trail |
| **Data** | Database writes, migrations, backups, user PII | Rollback, Backup verification, Deletion policy |
| **Deployment** | CI/CD, production pushes, DNS, CDN | Pre-flight gate, Post-deploy verification, Rollback |
| **External APIs / 3rd Party** | Payment processors, email services, SMS | Rate limits, Cost-per-call, Fallback behavior |

---

### Mandatory Sections by Domain

#### Infrastructure / Deployment Skills MUST Have:

```
- [ ] Cost section: free-tier math, monthly ceiling, stage-gate table
- [ ] Scaling rules: what minScale/replicas/instances for current stage
- [ ] Post-deploy verification: commands to confirm config is cost-safe
- [ ] Orphan audit: command to find abandoned resources across regions
- [ ] Rollback procedure: exact commands, < 60 seconds to execute
- [ ] Approval boundary: what requires founder/human approval
```

#### Authentication / Security Skills MUST Have:

```
- [ ] Threat model: what attacks does this protect against
- [ ] Secret rotation: where secrets live, how to rotate without downtime
- [ ] Audit trail: how to check who accessed what
- [ ] Revocation: how to immediately kill compromised credentials
- [ ] Approval boundary: auth changes require human approval
```

#### Data / Migration Skills MUST Have:

```
- [ ] Backup verification: prove backup exists before destructive action
- [ ] Rollback procedure: exact restore command from backup
- [ ] Schema drift check: is migration history in sync with actual DB
- [ ] PII handling: where personal data flows, how to purge
- [ ] Approval boundary: data deletions require human approval
```

#### External API / Billing Skills MUST Have:

```
- [ ] Cost-per-call: how much does each API call cost
- [ ] Rate limits: documented limits + what happens when hit
- [ ] Budget ceiling: max spend before auto-stop or alert
- [ ] Fallback: what happens if the service is down
- [ ] Monitoring: how to check current usage/spend
```

---

### Quick Audit Command (for existing skills)

Run mentally or in a checklist when loading a skill for infra work:

```
1. What domain does this skill touch? (infra/billing/auth/data/deploy/external)
2. Does it have a cost/budget section? (if infra/billing/deploy/external)
3. Does it have a rollback section? (if deploy/data/auth)
4. Does it have post-action verification? (if deploy/infra)
5. Does it have an approval boundary? (if auth/data/billing)

Missing any → FLAG IT. Add the section before executing.
```

---

### The $5 Rule (Incident Prevention Heuristic)

> If a single misconfigured flag in this skill could cost the founder money while
> they sleep — the skill MUST have a cost section, a verification step, and an
> explicit stage-gate. No exceptions. A pre-revenue app burning $5/month on idle
> resources is a skill failure, not an infrastructure failure.

---

### Integration with Other Modules

- **Module 08 (Correction):** After writing a learning log for a skill gap → run this checklist on the skill and fix it.
- **Module 07 (Handoff):** If you modified a skill this session → note it in handoff.
- **Reference 01 (Audit Protocol):** Expanded audit now includes skill integrity check (see updated protocol).
- **manus-creator / skill-creator:** When packaging a new skill → this checklist is a release gate.
