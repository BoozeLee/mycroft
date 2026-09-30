# Vision — Mycroft

## The problem, stated without jargon

A mid-sized European company decides to "do AI". Six weeks later someone has a pilot, a
budget, and a compliance question nobody can answer. Three months after that they have a
model in production they cannot explain to their auditor, and a board that has stopped
asking what it returns.

The failure is not model choice. It is that nobody with enough technical judgement has
enough time to look at all the candidates at once, and nobody with business context has
enough technical judgement to rank them. The fractional CAIO exists to be the person who
has both, for a bounded period, on a bounded question.

## The insight the product is built on

**The valuable output of an AI advisory engagement is the kill list, not the plan.**

Every consultancy sells the plan, because the plan is what gets signed. But the plan's
value is realised at the moment a decision is *not* taken. A client who leaves with a
twelve-month AI roadmap and builds the wrong thing has been harmed and billed. A client who
leaves with a defensible statement of "these three of your eight ideas are legal, useful,
and worth two weeks each, and these five are not" has been helped.

So: the deliverable leads with what to stop.

## Three horizons

### H1 — Prove the instrument (months 0–3)

- One diagnostic method, written end to end, ten working days, fixed price.
- Three engagements delivered. Not five — three is enough to learn, and each one costs
  roughly a week of the founder's time.
- The method changes after every engagement, visibly, in `docs/DECISIONS.md`. If it does not
  change, the engagements were not real diagnostics.
- **Success:** three paid engagements, at least one client acting on the kill list, and a
  method that is measurably tighter than the first draft.

### H2 — Make it repeatable without the founder (months 3–9)

- The method is split into a reusable intake, a reusable diagnostic template, and a reusable
  obligation map. The map is shared with `scotland-yard`, so the regulatory research is done
  once across the portfolio.
- A second delivery path: a **fixed-price diagnostic workshop**, two days, group of up to
  eight, where the method is taught rather than performed. Cheaper to sell, lower margin,
  and it finds the people who are not ready to buy an engagement but will be in six months.
- **Success:** one engagement delivered by someone other than the founder, at ≥80% of the
  founder's margin.

### H3 — Let the method have a life beyond the engagements (months 9–18)

- The accumulated obligation map, sector by sector, becomes the thing clients actually
  want — and it is cheap to maintain, because the regulation itself changes on a schedule.
- Referrals replace outbound. A diagnostic that names a kill list is remembered.
- **Success:** ≥50% of new engagements arrive by referral, and the engagement price can be
  raised twice without losing the funnel.

## The moat

There is no technical moat and there should not be. The moat is **accumulated, dated,
sector-specific regulatory judgement that nobody else has written down.**

Regulation is a public document. Interpretation is not. The defensible asset is: for
Belgian companies of this size, in these sectors, on these dates, this is what is required
and this is what is not — with the reasoning preserved, so it can be re-checked when the
regulator changes its mind. That asset gets more valuable every month the regulation
phases in, and it cannot be bought, because it is a function of having done the work.

Second-order moat: reputation for saying no. A seller who has never told a client to stop
is not trusted when they do.

## Kill criteria

This section is the reason the plan is worth reading. It is written first, and it is
enforced.

| # | Signal | Deadline | Action |
|---|---|---|---|
| K0a | No real company the founder does not work for, and has no financial interest in, had agreed to the intake by week 3 | week 3 | Nothing was asked of a stranger. The problem is either not real or not reachable by one person with this method. Do not lower the bar on who counts as a subject. Close the outreach and let K1 decide. |
| K0b | The unpaid Phase 1 diagnostic changed `diagnostics/method.md` not at all | week 3 | The method is a template, not a method. Write down what the first real business actually changed, or close the lane. Do not carry it forward unchanged and call it experience. Decided only if K0a passed. |
| K1 | Zero paid engagements after 3 qualified conversations | week 8 | Stop. The problem is not real or the buyer is not reachable. Do not lower the price to find out. |
| K2 | Engagements are bought as implementation, not as diagnosis | any 2 consecutive | Narrow the offer. Add a written "we do not build it" clause. If it still happens, the buyer wants a contractor and this lane is wrong. |
| K3 | Time-to-deliver exceeds 10 working days more than twice | by engagement 5 | The scope is wrong. Cut scope; never extend the timeline. |
| K4 | An engagement requires legal advice to complete | any 1 | Escalate to a lawyer, bill at cost, and record the limitation. This lane does not carry professional liability. |
| K5 | Fewer than 2 engagements in a calendar quarter after H2 | quarter 7 | Convert to a content-and-referrals lane. Stop the delivery capability. |
| K6 | The founder is the only person who can deliver the method | month 12 | H2 has failed. The method was never written down. Rewrite it or close the lane. |

K0a, K0b, K1, and K6 are the four that will actually fire. Everything else is a guardrail. K0a
and K0b fire first and fire soonest, because they are the only two that can be decided without
a single client conversation. K0 was one criterion with no antecedent: it presupposed a
diagnostic that no available subject could produce, so on its original date it could neither
pass nor fire (ADR-0012).

## What would make this a bad bet

- Advisory demand is local, relationship-driven, and cannot be scaled by a solo operator
  with 10–12 hours a week. If the honest answer is "this only ever produces eight
  engagements a year", it is still worth running, but it must be reported as a
  practice, not a company.
- The EU AI Act may be delayed. A delay does not kill the obligation map, but it does
  compress the window in which "get ahead of this" is a buying reason.
- The best version of this business is a book and a keynote. If the diagnostic cannot be
  separated from the founder's personal network, that is the ceiling, and it should be
  named early rather than discovered in month 14.
