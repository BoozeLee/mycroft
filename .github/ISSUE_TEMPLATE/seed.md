---
name: Seed task
about: Work on the Mycroft fractional advisory lane
title: "[seed] "
labels: ["seed"]
---

## What this is

<!-- One or two sentences. If you cannot write this without adjectives, the issue is not ready. -->

## Why now

<!-- Which phase, and which acceptance criterion in docs/BUILD-PLAN.md it moves. -->

## Acceptance

<!-- Copy the phase's acceptance criterion verbatim from docs/BUILD-PLAN.md. -->

## Verify

<!-- The exact command, in backticks, copied from docs/BUILD-PLAN.md. -->

## Constraints

- Markdown only. No dashboard, CRM, or automation platform (ADR-0003).
- No credentials in the tree.
- No hourly framing in client-facing text.
- If this touches the price, the scope, or a kill criterion, add an ADR to `docs/DECISIONS.md` in the same PR.

## Out of scope

- Implementation work for clients. Referrals only (ADR-0004 context, K2).
- Legal advice. Escalate.
- Any claim that the verify gate validates demand. It validates writing discipline.
