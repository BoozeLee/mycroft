> **Development home:** https://github.com/BoozeLee/mycroft — public, CI-enabled (seed verify gate + docs checks on every push/PR). This org copy is the private archive.

# Mycroft

> *Mycroft Holmes: Sherlock's brother, who sees everything and says almost nothing. He is consulted on a slice of a case, gives his opinion, and withdraws.*

**Status:** seed · no code · no customers
**Lane:** fractional advisory, sold as a scoped diagnostic
**Owner:** Kiliaan Vanvoorden · Bakerstreet Labs

---

## The one-line version

Fractional CAIO advisory, sold as a **fixed-scope diagnostic engagement** with a written
Minimum Viable Action — not hourly consulting, not a strategy deck.

## Why this is the most promising of the six

The six candidate lanes were ranked on two things only: how fast the first euro can arrive,
and how much of the input is already on disk.

| Candidate | Time to first euro | Input already exists | Verdict |
|---|---|---|---|
| Fractional CAIO (`mycroft`) | ~3 weeks | Yes — the EU AI Act diagnostic material, the existing advisory plan drafts | **rank 1** |
| Open-core gated access (`hansom-cab`) | ~6 weeks | Yes — 70 existing private repos are the inventory | rank 2 |
| Niche vertical automation | ~3 months | No — four verticals, none chosen | rejected as scoped |
| Agent marketplace publisher | ~9 months | No — needs a two-sided cold start on a network effect | rejected |
| White-label agent SaaS | ~4 months | No — commodity wrapper around Dify/OpenWebUI | rejected |
| Decentralized AI mining | never | No | rejected to `the-apiary` (research only) |

Two of the six are services businesses wearing a repository costume. That is deliberate: the
repository *is* the instrument. A diagnostic nobody can reproduce is a consultancy; a
diagnostic with a written method, a template, and a definition of done is a product that
happens to be delivered by a person.

## Who pays

A founder or COO at a 15–200 person Belgian or EU company who has been told by the board,
a client, or a competitor that they need AI, and has no way to tell whether the thing they
are building is (a) legal, (b) useful, or (c) both.

They are not paying for a strategy. They are paying to find out which of their three ideas
should be killed before they spend a quarter on it.

## What the customer receives

One written diagnostic, delivered in **ten working days**, containing:

1. **Intent inventory** — every AI use case in the business, ranked by cost of being wrong.
2. **Obligation map** — where the EU AI Act bites, with a named article and a named date.
3. **Provider and data map** — what is currently wired to what, and which leg is the risk.
4. **Three MVA candidates** — each scoped to under two weeks of engineering, with the
   decision it produces, the cheapest way to test it, and what would falsify it.
5. **A kill list** — the ideas that should not be built, and why. This section is the one
   clients quote back.
6. **Obligation calendar** — the three dates that actually matter for their size class.

## What this is not

Not hourly work. Not a strategy deck. Not implementation. Not a retainer that quietly becomes
a second job. If a client needs ongoing execution, they are referred out — that constraint is
what makes the diagnostic credible and what protects the 10-week cap.

## Non-goals

- No autonomous agent framework. Four already exist in this organisation and a fifth is a
  liability, not an asset.
- No tooling, dashboard, or platform. The instrument is Markdown.
- No hourly billing. Time-boxed, fixed price, or nothing.
- No ML model training, no fine-tuning, no GPU work.
- No claim of legal advice. This is engineering risk assessment against a published
  regulation, and the document says so on page one.

## Where it sits

| Repo | Role |
|---|---|
| `mycroft` | The advisory engagement and its commercial terms |
| `casebook` | The diagnostic → MVA instrument itself (the method that makes this reproducible) |
| `scotland-yard` | The EU AI Act obligation map, machine-readable, shared across lanes |
| `221b` | Portfolio hub and seed registry |

## Current state

Nothing is built. No code, no customers, no engagement template. What exists is this
document set, and `scripts/verify-seed.sh` proves the document set is internally
consistent — which is a statement about writing discipline, not about demand.

## Verify

```bash
bash scripts/verify-seed.sh
```

Expect `RESULT: PASS — internally consistent seed, unproven idea`. Anything else means this
file is lying about the state of the repository.
