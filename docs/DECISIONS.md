# Decisions — Mycroft

Format follows the usual shape: context, decision, consequence. Newest first.

---

## ADR-0005 — The method changes after every engagement, or the engagement was theatre

**Date:** 2026-09-29 · **Status:** accepted

**Context.** The whole lane rests on a claim that a personal advisory judgement can be
turned into a method. The obvious failure mode is that it does not change, and six
engagements are narrated by the same person with the same opinions.

**Decision.** After every engagement, something in `diagnostics/method.md` must change
measurably, and the change is recorded here with its reason. "No change" is a permitted
outcome exactly once, in engagement one, and never again.

**Consequence.** The method is a moving target during H1, so the offer in Phase 2 cannot
promise a fixed deliverable structure indefinitely — it promises the *six sections*, which
are stable, while the method inside them improves. If the method ever stops changing, the
lane is a practice and `docs/MONETIZATION.md` K6 applies.

---

## ADR-0004 — Paid on signature, no platform, no escrow

**Date:** 2026-09-29 · **Status:** accepted

**Context.** Payment could run through a hosted checkout, a marketplace, or an escrow
service. Each adds an integration, a fee, and a dependency on a third party's uptime during
a ten-day engagement with a real client.

**Decision.** Invoice on signature, due in 14 days, bank transfer, no payment processor, no
escrow, no marketplace listing. The engagement letter is one page of plain language.

**Consequence.** ~€40 of fees per engagement is accepted as a cost. Late payment is a
manual conversation rather than an automated dunning — accepted, because at three
engagements per half-year the automation would cost more time than it saves. Revisit only
if volume passes ten engagements a year.

---

## ADR-0003 — No SaaS, no dashboard, no Notion/Amplitude/Mixpanel/Make/Zapier

**Date:** 2026-09-29 · **Status:** accepted

**Context.** ori's first pass proposed a full commercial stack for this lane. The founder
has 10–12 hours a week across everything, and administrative tooling is the most reliable
way to convert a 10-day engagement into a 10-day engagement plus two days of feeding a
tool.

**Decision.** The entire administrative state of this lane is one Markdown file,
`docs/LOG.md`. No CRM, no analytics, no automation platform, no form builder.

**Consequence.** Pipeline tracking is manual and imprecise, which is the correct trade at
this volume. `scripts/verify-seed.sh` fails the build if any of these tool names appear in
the repository, so the decision cannot erode silently through a later commit.

---

## ADR-0002 — The deliverable leads with the kill list, not the plan

**Date:** 2026-09-29 · **Status:** accepted

**Context.** The conventional deliverable is a roadmap. The roadmap is also what gets
signed, and its value is only realised if the client acts on it.

**Decision.** The diagnostic's most prominent section is the list of ideas that should not
be built, with reasons. The roadmap is subordinate.

**Consequence.** The offer has to promise that the founder will tell a client to stop
something, which loses deals with clients who have already decided what they want built.
That is the intended filter, and it is why the qualified-conversation count in Phase 3 is
twelve messages rather than twelve leads.

---

## ADR-0001 — Named `mycroft`, and the repository is the instrument

**Date:** 2026-09-29 · **Status:** accepted

**Context.** The six candidate lanes arrived with plain-descriptive names and invented
commercial brands ("AI Compass Advisory", "Agent Forge", "AgentPortal Pro", "VerticalAI").
The organisation's existing work is Sherlockian, and the owner requires the theme held
consistently.

**Decision.** Repo `mycroft` — the brother who observes, advises on a slice, and withdraws,
which is the engagement model. No commercial brand, no tagline, no invented trademark. The
unregistered brand names were dropped for two reasons: they are not defensible, and a repo
name that already says what the repo is does not need a second name.

**Consequence.** `mycroft` does not search as "fractional CAIO" and will not be found by a
prospect googling that phrase. Accepted deliberately: the buyer is not searching for a tool,
and `221b` carries the searchable description for the portfolio. Flagged in the open
questions on `221b` as the most likely of the eight to be renamed if outbound ever
outweighs theme.

---

## ADR-0000 — A repository with no code, on purpose

**Date:** 2026-09-29 · **Status:** accepted

**Context.** The default expectation of a seeded repository is a scaffold and a run command.
This one has neither, and a plan-only repository is exactly the wish-list failure the owner
asked to avoid.

**Decision.** Accept a plan-only seed, but make the plan falsifiable: six named kill
criteria, three that are load-bearing (K1, K6, K2), each phase with one acceptance
criterion and one executable verify command, and a `verify-seed.sh` that fails on missing
monetization terms, missing kill criteria, TODO markers, credential-shaped strings, and
SaaS-bloat vocabulary.

**Consequence.** The gate proves the plan is well-formed and states its own uncertainty. It
proves nothing about demand, and `README.md` says so in those words so nobody can cite a
green gate as validation. The first runnable artefact this lane is allowed to claim is
`diagnostics/001-<company>.md` in Phase 1 — a real diagnostic on a real company, which is
Phase 1's acceptance criterion and not a later phase's.

## ADR-0006 — This lane's copy of the gate was hardened, and why

**Date:** 2026-09-29 · **Status:** accepted

**Context.** The shared `scripts/verify-seed.sh` had two blind spots, found in a sibling lane
(`hansom-cab`) and negative-tested there: the credential and TODO checks did not read untracked
files, because they used `git grep`, and the gate never opened the verify scripts it pointed
at, so a script that fabricated its own evidence left the gate green. Both are recorded in
`221b` ADR-0005 and in `hansom-cab/docs/QUARANTINE-2026-09-29.md`.

**Decision.** This lane's copy is updated to the same bytes as `221b` and `hansom-cab`. The
gate now fails on untracked files, scans the working tree, and fails on a `scripts/verify-*.sh`
that simulates its inputs, scores itself with arithmetic, or carries a hardcoded address book.

**Consequence.** Phase 1 of this lane — a real diagnostic on a real company, the only phase
that cannot be faked — is unaffected in substance, and better protected in form. The first
artefact this lane is allowed to claim is still `diagnostics/001-<company>.md`, and the gate
still proves nothing about whether anyone will pay €3,500.

**Superseded in part by ADR-0007** (2026-09-29): the byte-identity decision above no longer
holds, by deliberate exception.

## ADR-0007 — This lane's gate now diverges from the shared bytes, and why

**Date:** 2026-09-29 · **Status:** accepted · **Supersedes:** ADR-0006 (byte identity only)

**Context.** ADR-0006 made this lane's `scripts/verify-seed.sh` byte-identical to `221b` and
`hansom-cab`. Testing that identity on 2026-09-29 found three things, and only the first is the
one this ADR set out to fix.

First, and real: `.gitignore` line 13 ignores `node_modules/`, while the untracked-file check
reads `git ls-files --others --exclude-standard`, which honours `.gitignore`. A `node_modules/`
tree is therefore invisible to it. Measured: with a populated `node_modules/` present, the gate
reported `PASS no untracked files`. This is not hypothetical — `npm install` had been run in
this repo, which is how the blind spot was found. `dist/` is not ignored, so the untracked
check already catches that one.

Second, the two content scans that look for our own prose do not in fact false-positive on that
tree, for a reason nobody designed. Both apply a negation filter to the whole `grep` line, and
a `grep` line is `./path:lineno:text`. The path `node_modules` contains the cue `no`, which the
filter's `no|not|never|…` alternative matches, so every line under that directory is discarded
before counting. Measured on planted bait: 6 raw matches, 0 after the filter.

Third, and a pre-existing defect this change does not fix: the same filter runs on the file's
own text, and `notion.so` begins with `no`. Measured: a top-level file reading `we track all
usage in notion.so` produced 4 raw `grep` hits and the verdict `PASS no off-the-shelf SaaS
backlog filler`. The ban's primary term cannot fire, and any path or term beginning with a
negation cue is exempt the same way.

**Decision.** The vendor scan and the unfinished-work scan gain
`--exclude-dir=node_modules --exclude-dir=dist`. The credential scan deliberately does not,
and a comment in the script records why. A credential control should fail closed: excluding
those directories would silently miss a real key written there, and a silent false negative in
a credential scan is a worse defect than a false positive a human dismisses after looking. It
is also the one scan with no accidental exemption — measured, it did reach into `node_modules/`
and catch a planted `AKIA…` string. It costs about 1s over 59MB, so the coverage is not
expensive.

**Consequence.** This lane's `verify-seed.sh` is no longer the same bytes as `221b` and
`hansom-cab`, and a byte check across the three will now fail on purpose. The `.gitignore`
blind spot exists in all three lanes, so this is a real fix currently applied to one.
Propagation is a follow-up and is deliberately not bundled: siblings are changed one at a
time, after this change has been reviewed.

Both defects are recorded rather than fixed here. The accidental `node_modules` exemption is
now explicit and no longer depends on a regex coincidence, which is the part this change
actually buys. The self-exempting vendor term was a separate change to the filter's semantics and
got its own decision, **ADR-0008**, merged after this one. Until it landed, the vendor ban's
primary term was decorative, in this lane and in both siblings.

## ADR-0008 — The vendor ban could not fail, and why the filter changes shape

**Date:** 2026-09-29 · **Status:** accepted · **Supersedes:** ADR-0007 (third finding only)

**Context.** ADR-0007 recorded a third defect and did not fix it: the negation filter runs on the
file's own text as well as on the path, and the primary banned vendor name opens with the two
letters the filter's first cue is built from. A line naming that vendor matched the filter and
discarded itself. The ban was decorative — it could not fail on any line, at any path, even once
the path half of the problem was solved.

Measured on 2026-09-29 in a copy of this repo, with one tracked bait file whose entire content was
a single line naming two banned vendors and carrying no prohibition: the gate exited **0**, printed
`PASS no off-the-shelf SaaS backlog filler`, and invoking the scan function in that tree returned
`0`. Two banned names, no finding.

**Decision.** The filter stops reading the path, and the banned term is removed from the line
before the filter reads the text. Two changes, both required — solving either one alone leaves the
ban unable to fire.

1. `-h` on both recursive scans, so the `./path:lineno:` prefix never enters the pipeline. The gate's
   self-exclusion moves from a path grep to `--exclude='verify-seed.sh'`, which matches the
   basename. The path is now absent rather than filtered, so no cue in a future directory name can
   exempt a line.
2. `sed -E "s%<pattern>%%gI"` between the match and the filter, so a cue inside the word being
   banned cannot exempt that word. A cue about the line is a prohibition; a cue inside the term is
   only a spelling.

The single-file `count_affirmative` is deliberately untouched. It reads one file by name, so its
output carries no path, and its one call site's pattern contains no cue. The credential scan is
untouched for the reason ADR-0007 gives — it fails closed, and it never had this defect because it
applies no filter at all.

**Consequence.** Measured after the change, on the same bait: the gate exits **1** and reports one
line referencing the banned vendors. On this repo it exits **0**. The legitimate prohibitions that
name these vendors survive, because the filter still reads the prose around the term, which is what
it was written to do. The change found one real hit on the way through, in the ADR above: prose
naming a vendor with no prohibition on the same line, which is exactly what the ban is for. That
line was reworded; the filter was not weakened to accommodate it.

**Not fixed, on purpose.** The vendor pattern spells two vendors as bare names and three as
domains, so a bare mention of the other three is not matched at all. Widening it is a separate
change and wants its own evidence. The residual weakness of a cue-anywhere-on-the-line filter is
also unchanged: a line carrying both a real breach and an unrelated prohibition is still missed.
Both are recorded in issue #6.

**Still open.** This lane's `verify-seed.sh` has now diverged from `221b` and `hansom-cab` twice
over, and both carry this defect. Propagation stays deliberately unbundled: siblings are changed
one at a time, after this change has been reviewed.

## ADR-0009 — K0: the first real business must change the method

**Date:** 2026-09-29 · **Status:** accepted

**Context.** The lane had six kill criteria and not one of them could fire before a client
conversation happened. K1 is week 8, K2 needs two engagements, K3 needs five, K4 needs one
engagement, K5 is quarter 7, K6 is month 12. Every one of them sits downstream of a sale or a
delivery. That left a hole of the same shape as the one this repo had already found twice: a
check that cannot fail is not a check.

The hole is not hypothetical. `diagnostics/method.md` is written from the CLI contract and the
scaffold, and both are products of this repo. Writing it is cheap. Running the diagnostic on a
real company is the only thing that makes it a method, because a method is a procedure that
survived contact with something that objected. The build plan already says this in one line —
"the only phase that cannot be faked" — and then nothing enforced it. As of 2026-09-29 the file
did not exist and the week-3 deadline was eight days past nothing at all.

**Decision.** Add K0, firing at week 3 (2026-10-20): if the unpaid Phase 1 diagnostic produced
no dated revision to `diagnostics/method.md`, the method is a template, not a method. Write
down what the first real business actually changed, or close the lane. Do not carry it forward
unchanged and call it experience.

K0 sits above K1 deliberately. It is the only criterion in the table that can be decided
without a single client conversation, which makes it the only one that can be evaded by
inaction. K1 punishes a market that does not answer. K0 punishes a method that was never
tested, and waiting for the market to answer is a way of not running it.

**Consequence.** The closing line of `VISION.md` no longer says two criteria will fire; it now says
three, and it now says why the earliest one is the one about the founder's own work. Phase 1
remains blocked on naming a real company, so K0 is currently on a clock with no input
available to it — that is the honest state, and issue #4 is the thing that has to change.

**The check.** It lives in `scripts/verify-method.sh` in the private toolkit, not in this repo,
because that is where the phase gates are and this repo carries no code (ADR-0000). The check
is driven by the calendar rather than by a file being absent: before 2026-10-20 it reports that
K0 is not yet due, and on and after that date a missing dated revision is a failure. That
distinction matters, because three sibling gates infer "not yet" from a file not existing,
which makes the not-yet state a property of the filesystem rather than of the date. Rewriting
those three is ADR-0010's job, not this one's.

**Not in scope.** K0 does not judge whether the first diagnostic was any good, and it does not
require a client to exist — running the diagnostic unpaid on a real company is the whole test.
Nor can it tell a revision that records something real from one that records nothing. That
limit is stated in the gate rather than hidden, on the same principle as the "read this
yourself" footers.
