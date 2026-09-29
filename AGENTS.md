# Mycroft

Fractional CAIO advisory as a scoped diagnostic. See `README.md` for what it is,
`VISION.md` for why and when to stop, `docs/BUILD-PLAN.md` for phases,
`docs/MONETIZATION.md` for price and break-even.

## Working rules

- **Markdown is the instrument.** Do not introduce a dashboard, CRM, or automation
  platform. `scripts/verify-seed.sh` fails the build on Notion/Amplitude/Mixpanel/Make/
  Zapier references; that is deliberate and it is a decision, not a lint.
- **No credentials, ever.** No API keys, no tokens, no `.env` in the tree. Client material
  is referenced by slug (`diagnostics/001-<company>.md`) and never committed with real
  company names or financials.
- **Every phase needs both halves.** An acceptance criterion in words and a verify command
  in backticks that can be run. A phase with a verify line containing no command fails the
  gate.
- **Every claim carries a deadline.** A kill criterion without a week number is a
  preference. If you add or change one, put the week in the same cell.
- **The kill list is the product.** When writing about what this lane delivers, put the
  stop-list before the roadmap. If a document leads with a plan, it is off-message.
- **No hourly language in the offer.** Fixed price or nothing. `docs/MONETIZATION.md` states
  the day rate arithmetic honestly; do not paper over it.
- **The method must change.** After each engagement, `diagnostics/method.md` gets a dated
  revision recorded in `docs/DECISIONS.md`. "No change" is allowed once, in engagement one.
- **No legal advice, ever.** The obligation map is engineering risk assessment against a
  published regulation, escalated to a lawyer where professional liability attaches. Every
  client document says this on page one.
- **Verdict, not activity.** Before a commit, run `bash scripts/verify-seed.sh` and report
  its output. "Documents updated" is not a result; `RESULT: PASS` is.

## Repo state

Plan-only seed. No code, no customers, no templates. The green verify gate says the plan is
internally consistent and that the idea is unproven — both halves matter, and quoting only
the first is a misrepresentation.
