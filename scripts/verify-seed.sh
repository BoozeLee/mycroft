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

  # A verify command that cannot fail is not a verify command. `bash -c "echo ..."` exits 0
  # forever and would satisfy a backtick check forever, which is how a plan gets to look
  # verified while nothing is ever tested. Reject the tautologies.
  taut=$(grep -E '^\*\*Verify:\*\* ' "$plan" \
    | grep -icE '`[^`]*(echo|true|:>|printf)[^`]*`|[[:space:]]true[[:space:]]*`|(exit[[:space:]]+0)' || true)
  if [[ "$taut" -eq 0 ]]; then ok "no tautological verify commands"
  else bad "$taut verify lines run a command that always exits 0"; fi

  # Every verify command must actually exist in the tree, or reference an obvious external
  # binary. A script that is named but absent is an honest "not built yet"; a script named
  # with a typo is a phase that can never pass.
  missing=$(grep -oE '`bash scripts/[A-Za-z0-9._-]+\.sh' "$plan" | sed 's/`bash //' | sort -u \
    | while read -r s; do [[ -f "$s" ]] || printf '%s ' "$s"; done)
  if [[ -z "$missing" ]]; then ok "every referenced verify script exists or is not yet written"
  else note INFO "verify scripts not yet written (expected pre-build): $missing"; fi
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
# A file outside version control is a floor the gate cannot see: a green run would
# describe the committed plan while an unreviewed script sat beside it printing its
# own verdict. Nothing untracked is allowed to exist, so nothing can hide there.
untracked=$(git ls-files --others --exclude-standard 2>/dev/null | tr '\n' ' ')
if [[ -z "${untracked// /}" ]]; then
  ok "no untracked files"
else
  bad "untracked files outside version control: $untracked"
fi

# git grep only reads tracked files, so a credential in an untracked file used to
# pass the gate. Scan the working tree instead.
if grep -rIE '(sk-[A-Za-z0-9]{16,}|AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{20,})' . --exclude-dir=.git >/dev/null 2>&1; then
  bad "credential-shaped strings in the working tree"
else
  ok "no credential-shaped strings"
fi
todos=$(grep -rInE '\b(TODO|FIXME|XXX)\b' . --exclude-dir=.git 2>/dev/null | grep -v 'scripts/verify-seed\.sh' | grep -viE "$negation" | wc -l || true)
if [[ "$todos" -eq 0 ]]; then ok "no TODO/FIXME markers"
else bad "$todos TODO/FIXME markers (finish or file an issue)"; fi
vendor=$(count_affirmative_tree 'notion\.so|amplitude|mixpanel|make\.com|zapier\.com')
if [[ "$vendor" -eq 0 ]]; then ok "no off-the-shelf SaaS backlog filler"
else bad "$vendor lines reference Notion/Amplitude/Mixpanel/Make/Zapier"; fi

echo
echo "-- verify scripts are instruments, not actors"
# A verify script that invents its recipients, counts its own successes with a
# modulo loop, or describes itself as a simulation is not measuring anything. It
# is the shape found in hansom-cab on 2026-09-29: a script that reported sponsor
# interest it had never asked anyone for. Real evidence is read from a real log.
vscripts=()
for f in scripts/verify-*.sh; do [[ -f "$f" ]] && vscripts+=("$f"); done
if [[ "${#vscripts[@]}" -eq 0 ]]; then
  ok "no verify scripts written yet (expected at seed depth)"
else
  fakes=()
  for f in "${vscripts[@]}"; do
    [[ "$f" == "scripts/verify-seed.sh" ]] && continue
    if grep -qiE 'simulat' "$f" \
       || grep -qE '\$\(\([^)]*%[[:space:]]*[0-9]' "$f" \
       || grep -qE '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' "$f"; then
      fakes+=("$f")
    fi
  done
  if [[ "${#fakes[@]}" -eq 0 ]]; then
    ok "${#vscripts[@]} verify script(s) present, none fabricate their own evidence"
  else
    bad "verify script(s) fabricate their own evidence: ${fakes[*]}"
  fi
fi

echo
if [[ "$fail" -eq 0 ]]; then
  echo "RESULT: PASS — internally consistent seed, unproven idea"
else
  echo "RESULT: FAIL — see FAIL lines above"
fi
exit "$fail"
