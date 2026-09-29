#!/usr/bin/env bash
# Shared seed verify gate. Vendored verbatim into every seed repo and the hub.
# Exit 0 = the seed is internally consistent. Exit 1 = a human must look.
#
# This checks DOCUMENT CONSISTENCY, not product quality. At seed depth that is
# the honest gate: there is no code, so there is nothing to test. A green run
# means "the plan is well-formed and stated honestly", never "the idea works".

set -uo pipefail

required_files=(
  "README.md"
  "VISION.md"
  "AGENTS.md"
  ".gitignore"
  "LICENSE"
  "docs/BUILD-PLAN.md"
  "docs/MONETIZATION.md"
  "docs/DECISIONS.md"
  ".github/ISSUE_TEMPLATE/seed.md"
)

fail=0
note() { printf '  %-8s %s\n' "$1" "$2"; [[ "$1" == FAIL ]] && fail=1; }
ok()   { note PASS "$1"; }
bad()  { note FAIL "$1"; }

# A vocabulary ban has to be able to live in the documents that *state* the ban,
# otherwise writing down the rule fails the rule. So a line only counts as a
# violation when the banned term appears without a prohibition cue on the same
# line. "No passive income framing" is the ban; "revenue is passive income" is
# the breach.
negation='(^|[^a-z])(no|not|never|without|zero|deliberate|ban|exclud|avoid|instead of|rather than|forbid|reject|drop|kill)'
count_affirmative() {
  local pattern="$1" file="$2" n
  n=$(grep -inE "$pattern" "$file" 2>/dev/null \
      | grep -viE "$negation" \
      | wc -l || true)
  printf '%s' "$n"
}
count_affirmative_tree() {
  local pattern="$1"
  # -i matters: a banned vendor reintroduced as "Amplitude" or "Make.com" must still
  # fail, and a case-sensitive scan lets the capital-A spelling through.
  grep -rInEi "$pattern" . --exclude-dir=.git 2>/dev/null \
    | grep -v '^\./scripts/verify-seed\.sh:' \
    | grep -viE "$negation" \
    | wc -l || true
}

echo "seed verify: $(basename "$(git rev-parse --show-toplevel 2>/dev/null || pwd)")"
echo

echo "-- required files"
for f in "${required_files[@]}"; do
  if [[ -s "$f" ]]; then ok "$f"; else bad "$f (missing or empty)"; fi
done

echo
echo "-- build plan phases"
plan=docs/BUILD-PLAN.md
if [[ -s "$plan" ]]; then
  phases=$(grep -cE '^## Phase [0-9]+' "$plan" || true)
  if [[ "$phases" -ge 3 ]]; then ok "$phases phases declared"
  else bad "$phases phases declared (need >= 3)"; fi

  acc=$(grep -cE '^\*\*Acceptance:\*\* .+' "$plan" || true)
  ver=$(grep -cE '^\*\*Verify:\*\* .+' "$plan" || true)
  if [[ "$acc" -eq "$phases" && "$acc" -gt 0 ]]; then
    ok "every phase has an acceptance criterion ($acc)"
  else
    bad "acceptance criteria $acc vs phases $phases"
  fi
  if [[ "$ver" -eq "$phases" && "$ver" -gt 0 ]]; then
    ok "every phase has a verify command ($ver)"
  else
    bad "verify commands $ver vs phases $phases"
  fi

  # A verify line that is prose is not a verify command.
  prose=$(grep -E '^\*\*Verify:\*\* ' "$plan" | grep -vcE '`[a-z0-9_./-]+.*`' || true)
  if [[ "$prose" -eq 0 ]]; then ok "verify commands are commands, not prose"
  else bad "$prose verify lines contain no backticked command"; fi
else
  bad "$plan unreadable, skipping phase checks"
fi

echo
echo "-- money honesty"
mono=docs/MONETIZATION.md
if [[ -s "$mono" ]]; then
  if grep -qE '^\*\*Kill trigger:\*\* .+' "$mono"; then ok "kill trigger stated"
  else bad "no '**Kill trigger:**' line in $mono"; fi
  if grep -qE '^\*\*Break-even:\*\* .+' "$mono"; then ok "break-even stated"
  else bad "no '**Break-even:**' line in $mono"; fi
  if grep -qE '^\*\*Pricing hypothesis:\*\* .+' "$mono"; then ok "pricing hypothesis stated"
  else bad "no '**Pricing hypothesis:**' line in $mono"; fi
  crypto=$(count_affirmative '(revenue (is|comes from) (token|emission|crypto))|(passive income)' "$mono")
  if [[ "$crypto" -eq 0 ]]; then ok "no token/passive-income revenue claims"
  else bad "$crypto lines promise token or passive-income revenue"; fi
else
  bad "$mono unreadable, skipping money checks"
fi

echo
echo "-- hygiene"
if git grep -nIE '(sk-[A-Za-z0-9]{16,}|AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{20,})' -- . >/dev/null 2>&1; then
  bad "credential-shaped strings in tracked files"
else
  ok "no credential-shaped strings"
fi
todos=$(git grep -nIE '\b(TODO|FIXME|XXX)\b' -- . 2>/dev/null | grep -v 'scripts/verify-seed.sh' | grep -viE "$negation" | wc -l || true)
if [[ "$todos" -eq 0 ]]; then ok "no TODO/FIXME markers"
else bad "$todos TODO/FIXME markers (finish or file an issue)"; fi
vendor=$(count_affirmative_tree 'notion\.so|amplitude|mixpanel|make\.com|zapier\.com')
if [[ "$vendor" -eq 0 ]]; then ok "no off-the-shelf SaaS backlog filler"
else bad "$vendor lines reference Notion/Amplitude/Mixpanel/Make/Zapier"; fi

echo
if [[ "$fail" -eq 0 ]]; then
  echo "RESULT: PASS — internally consistent seed, unproven idea"
else
  echo "RESULT: FAIL — see FAIL lines above"
fi
exit "$fail"
