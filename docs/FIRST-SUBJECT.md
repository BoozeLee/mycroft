# Finding the first subject

**Why this file exists.** Kill criterion K0a asks whether one real company agreed to the
intake by **2026-10-20** (ADR-0012). As of 2026-09-30 none has, and the reason is not that the
lane lacks a plan. It is that "name one real company" is a request nobody can act on, because
the cost of a bad candidate is a real relationship. This file reduces the cost of finding out.

**What it is not.** It is not outreach copy and it is not a lead list. There is no list. The
candidates are people the founder already has a line to, and the only thing this file does is
make screening them cheap enough to do before the deadline rather than after.

## The five screening questions

Answer all five about a **candidate company**, in about ten minutes, without contacting anyone.
Three yes answers out of five is not enough. The first question is the one that decides it.

1. **Does this company already have an AI project someone has spent real effort on?**
   Not "are they interested in AI" — everyone is. A pilot, a budget line, a tool somebody
   chose, a thing already in production. The kill list has to point at something. A company
   with no AI project yet has nothing to kill, and the diagnostic degenerates into a sales
   conversation, which is a different business and a worse one.

2. **Who is the specific person, and would they be embarrassed to be told a project is
   illegal?**
   A named individual, not a company. Then the real test: if this diagnostic ends with
   "stop the project you are proud of", is that a conversation they can have? A polite
   contact who would be embarrassed is worse than no contact, because the answers will be
   shaped to avoid the finding.

3. **Is the founder completely free of any interest in this company?**
   Not employed by it, not contracted by it, not a shareholder, not investing in it, not
   advising it already, and not close to someone who runs it. A subject the founder has a
   stake in produces a self-assessment, and a self-assessment cannot fail the test the kill
   list exists to run. This is enforced mechanically, not by good intentions — the private
   gate fails any diagnostic that does not declare `subject_independence: external`.

4. **Could this person answer twelve questions in an hour without legal or HR sign-off?**
   If the answers need a lawyer or need to clear HR, kill criterion K4 fires the moment the
   engagement starts. Better to find that out here.

5. **Is the company mid-sized — roughly 20 to 500 staff?**
   Under about 20 there is usually no AI budget to be wrong about. Over about 500 the founder
   will not get an hour with anyone who can decide, and the questions will be answered by
   someone who does not know what the company is spending.

## Where a qualifying candidate actually comes from

In rough order of yield, from what has worked for solo consultants:

1. **Someone who has already asked the founder an AI question.** The highest-yield source
   by a wide margin, because asking the question proves both halves of the screen at once:
   they have an idea, and they are anxious about it. Every one of these is a candidate
   already sitting in an inbox or a chat history.
2. **A supplier the founder has actually delivered to**, in the last two years. Someone who
   has paid them has a reason to be candid, and a relationship that can absorb an unpaid
   diagnostic.
3. **A former employer.** Not the current one, ever.
4. **An expert group, peer group, or trade association** the founder already belongs to.

## The checkpoint: 2026-10-13

One week before K0a becomes decidable, the five questions get answered against whatever
candidates exist. There is no search after that date. One of two things happens:

- **A candidate passes.** `mycroft new <slug>`, send the twelve questions, and the week is
  spent on the diagnostic itself.
- **No candidate passes.** K0a fails on 2026-10-20 and says so in those words. That is a
  result, not an absence of one, and the decision it forces is made deliberately rather than
  by running out of calendar.

## What does not count

- The company the founder works for. The founder ruled this out in their own words and asked
  that it never be proposed again.
- A large group with no line to a decision-maker.
- A model, a persona, or a simulation. One exists in the private toolkit and is labelled as
  what it is. It is a rehearsal and it closes nothing.
- A company that has to be persuaded into being a case study. The diagnostic is unpaid and
  the output is the client's, not marketing material.
