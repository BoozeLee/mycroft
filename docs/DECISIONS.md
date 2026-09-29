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
actually buys. The self-exempting `notion.so` term is a separate change to the filter's
semantics and needs its own decision; until then the vendor ban's primary term is decorative,
in this lane and in both siblings.
