# Build plan — Mycroft

Ten working days per engagement, three engagements in H1. Each phase has one acceptance
criterion and one command that proves it. No phase is "done" on a feeling.

Verify this plan's own shape:

```bash
bash scripts/verify-seed.sh
```

---

## Phase 0 — Seed hygiene

*Week 0. Half a day. This repository as it stands.*

The plan has to be falsifiable before anything is built, otherwise every later phase is
negotiable.

- Vision, monetization and kill criteria written down, with a trigger on each.
- `scripts/verify-seed.sh` vendored and passing.
- Three seed issues open: *first slice*, *open decision*, *how we verify*.
- Labels `seed`, `vision`, `spike`, `blocked`, `monetization` applied.

**Acceptance:** the verify gate exits 0 and reports three or more phases, one acceptance
criterion and one verify command each.

**Verify:** `bash scripts/verify-seed.sh`

---

## Phase 1 — The method, on one real company

*Weeks 1–3. The only phase that cannot be faked.*

Take one real Belgian company the founder already knows — a supplier, a former employer, a
network contact. Not a friend being polite: someone who will answer a blunt question about
their AI budget. Run the full diagnostic on them, unpaid, and write down everything that was
awkward.

**The subject must be external, and that is a constraint on the subject rather than on the
work.** The company cannot be one the founder works for, one they hold a financial interest
in, or one they are on the point of being employed by. A subject the founder has a stake in
turns the kill list into a self-assessment, and a self-assessment cannot fail the test the
kill list exists to run. A simulated or model-answered subject is not a subject at all, and
the private gate refuses both. The acceptance criterion below is deliberately **not** amended
to make this phase reachable (ADR-0012), because a criterion rewritten so that a gate can pass
is the failure this lane has already caught in its own scripts.

Deliverables:
- `diagnostics/intake.md` — the questions asked before any analysis. Twelve questions,
  written so a non-technical founder answers them in under an hour.
- `diagnostics/method.md` — the diagnostic in order: intent inventory → obligation map →
  provider/data map → MVA candidates → kill list → obligation calendar.
- `diagnostics/001-<company>.md` — the first real diagnostic, kept even though it is unpaid,
  because it is the reference implementation of the method. Carries
  `subject_independence: external` in its frontmatter, and the private gate fails without it.

The point of running it unpaid is that the method cannot survive its first contact with a
real business otherwise. Every section that turns out to be unnecessary gets cut here, and
every section that turns out to be load-bearing gets written down.

**Acceptance:** `diagnostics/001-<company>.md` contains all six method sections, the MVA
candidates each have a falsification condition, and the kill list names at least two ideas
the client had already funded.

**Verify:** `bash scripts/verify-method.sh`

---

## Phase 2 — The offer, priced

*Weeks 3–5. Turn the method into something a stranger can buy.*

A diagnostic is not a product until it has a price, a scope, and a definition of done. All
three are currently missing, which is why nothing can be sold yet.

Deliverables:
- `docs/OFFER.md` — fixed price, the six sections the client receives, the ten-day
  delivery window, the exclusions, and the "we do not build it" clause stated in the
  offer rather than discovered during delivery.
- `diagnostics/../templates/engagement-letter.md` — a one-page engagement letter. Plain
  language, no defined terms, no penalty clauses.
- Payment: invoice on signature, due in 14 days, no platform, no SaaS, no escrow. The
  administrative cost of a payment processor must be lower than the cost of a client
  arguing about a refund.

**Acceptance:** the offer is one page, states a single price with no hourly component
anywhere, and the exclusions list contains at least implementation, training, and legal
advice.

**Verify:** `bash scripts/verify-offer.sh`

---

## Phase 3 — First three qualified conversations

*Weeks 5–9. The only phase that can kill the lane.*

Twelve outreach messages, not twelve leads. "I help Belgian companies find out which AI
projects are legal and which are not, in a ten-day diagnostic" — the message is the
test. If nobody replies, the problem is the message or the market, and both are worth
discovering in week 8 rather than month 6.

Kill criterion K1 fires here: zero paid engagements after three qualified conversations,
at week 8, means stop. Do not discount to manufacture a sale — a discount tells you the
price was wrong, and you need to find that out without confounding it with desperation.

- `docs/LOG.md` — one line per conversation, date, what they said, what they did.
- The three engagements, scheduled.

**Acceptance:** three qualified conversations logged, at least one engagement signed, and
the log states explicitly whether the price was rejected, the scope was rejected, or the
message was ignored.

**Verify:** `bash scripts/verify-pipeline.sh`

---

## Phase 4 — Deliver, and change the method every time

*Weeks 9–20. One engagement per three weeks, the remaining time on the next one.*

Three engagements, ten days each, plus the write-up. The rule that makes this a method
rather than a service: **after every engagement, something in `method.md` changes**, and
`docs/DECISIONS.md` records what changed and why. If engagement two produces no change to
the method, the method was not really being used — it was being narrated.

Kill criteria K2, K3 and K4 are watched here, in that order, because they are the ways a
diagnostic quietly turns into a build contract.

**Acceptance:** three engagements delivered, `method.md` has a dated revision for each, and
at least one client took an action traceable to the kill list.

**Verify:** `bash scripts/verify-engagements.sh`

---

## Phase 5 — Hand the method to someone else

*Months 4–9. The only test of whether this is a product.*

A second person — an intern, a contractor, a friend who reads — delivers engagement four
using only `intake.md` and `method.md`. No calls, no help. Every question they have to ask
the founder is a defect in the method, and gets logged and fixed.

This is K6, and it is the phase most likely to be quietly skipped. If the founder is still
the only person who can deliver in month 12, the honest conclusion is that this is a
practice, and the write-up should say "practice", not "product".

**Acceptance:** one engagement delivered by a second person with zero founder
intervention, and the defect list from that delivery is non-empty and filed.

**Verify:** `bash scripts/verify-handoff.sh`

---

## What is deliberately not in this plan

- No agent framework, no orchestration, no model routing. This organisation has four
  already.
- No SaaS, no dashboard, no CRM, no Notion/Amplitude/Mixpanel/Zapier/Make. The administrative
  state is one Markdown log, because a solo operator with 10–12 hours a week cannot afford
  a second job feeding a tool.
- No marketplace, no platform, no self-serve. The diagnostic is delivered by a person,
  because the client is buying judgement, and a self-serve form does not sell judgement.
