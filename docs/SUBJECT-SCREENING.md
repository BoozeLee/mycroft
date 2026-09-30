# Screening the candidates

**Why this file exists.** `docs/FIRST-SUBJECT.md` says the five screening questions get answered
before **2026-10-13** and that there is no search after that date. A date and a list of
questions, with nowhere to record the answers, is a preference. This file is the record.

**What it holds, and what it deliberately does not.** `AGENTS.md` forbids real company names in
this tree, and this repository is public. So the identities never come here. Each row carries a
private reference the founder keeps elsewhere — `S1`, `S2` — and the answers. If the reference
is written down nowhere, the row is still a screening result; it just cannot be acted on, and
that is a fault in the reference-keeping, not in this file.

## One row per candidate

| ref | screened | Q1 project | Q2 named person | Q3 no stake | Q4 one hour, no sign-off | Q5 20-500 staff | passed |
|-----|----------|-----------|-----------------|------------|--------------------------|----------------|--------|
| S0  | 2026-09-30 | -         | -               | -          | -                        | -              | -      |

`S0` is the template row, kept so the shape is never guessed at. `screened` is the date the
answers were given, not the date the candidate came to mind. Every question takes `y`, `n`, or
`?` for not yet answered.

**All five must be `y`.** Three out of five is not enough, and question 1 is the one that
decides it: a company with no AI project yet has nothing to kill, so the diagnostic degenerates
into a sales conversation. A candidate with `n` on Q1 is not a near miss, it is out.

## The rules that apply to every row

- **The founder's own employer is not a candidate.** Excluded in the founder's own words, and
  never to be proposed again. If a row would need that exception, the answer is no.
- **A model, a persona, or a simulation is not a candidate.** One exists in the private toolkit
  and is labelled as a rehearsal. It closes nothing.
- **A company that has to be persuaded into being a case study is not a candidate.** The
  diagnostic is unpaid and the output belongs to the client.
- **No new rows after 2026-10-13.** Not because searching is expensive, but because a deadline
  that can be extended is a preference.

## What gets written here on 2026-10-20

K0a becomes decidable on 2026-10-20. Whichever way it goes, the verdict goes in this file, in
one line, dated:

- If a row carries `passed: yes`, that row is the subject, its reference is resolved, and
  `diagnostics/001-<company>.md` is opened.
- If no row does, K0a fails and says so in those words. That is a result rather than an absence
  of one, and the decision it forces gets made deliberately instead of by running out of
  calendar.

A gate reads this file eventually. Until then it is a record kept for one person, which is a
weaker guarantee than a gate and a better one than a plan.
