#!/usr/bin/env bash
# Check a bootstrapped repository against the AI-Native Repository Standard templates.
#
# Usage: check_compliance.sh <standard_dir> <target_dir> [standard_sha]
#
# Exits 1 if any FAIL is reported. WARN lines are informational and need human attention.
set -uo pipefail

if [[ $# -lt 2 ]]; then
    echo "usage: $0 <standard_dir> <target_dir> [standard_sha]" >&2
    exit 2
fi

TPL="$(cd "$1/templates" && pwd)"
DST="$(cd "$2" && pwd)"
SHA="${3:-}"

fails=0
warns=0
fail() { echo "FAIL: $*"; fails=$((fails + 1)); }
warn() { echo "WARN: $*"; warns=$((warns + 1)); }
ok() { echo "ok:   $*"; }

# 1. Every template file must exist in the target.
while IFS= read -r -d '' file; do
    rel="${file#"$TPL"/}"
    [[ -e "$DST/$rel" ]] || fail "missing $rel"
done < <(find "$TPL" -type f -print0)

# 2. Verbatim files must be byte-identical to the template.
verbatim=(
    CLAUDE.md
    CONTRIBUTING.md
    tox.ini
    .gitignore
    .github/pull_request_template.md
)
while IFS= read -r -d '' file; do
    verbatim+=("${file#"$TPL"/}")
done < <(find "$TPL/.ai/rules" "$TPL/.ai/workflows" -type f -print0)

for rel in "${verbatim[@]}"; do
    [[ -e "$DST/$rel" ]] || continue
    if cmp -s "$TPL/$rel" "$DST/$rel"; then
        ok "verbatim $rel"
    else
        fail "$rel must be copied verbatim from the standard (it was modified)"
    fi
done

# 3. Parameterized files: only listed parameters may change, so check the invariants.
if [[ -f "$DST/pyproject.toml" ]]; then
    py="$DST/pyproject.toml"
    grep -Eq '^\[project\]|^\[tool\.poetry\]' "$py" || fail "pyproject.toml has no [project] or [tool.poetry] section (poetry install will fail)"
    threshold="$(grep -Eo 'fail_under *= *[0-9]+' "$py" | grep -Eo '[0-9]+$' || true)"
    if [[ -z "$threshold" || "$threshold" -lt 60 ]]; then
        fail "pyproject.toml coverage fail_under must be >= 60 (found: ${threshold:-none})"
    fi
    grep -q -- '--strict-markers' "$py" || fail "pyproject.toml lost --strict-markers"
    for marker in unit integration e2e slow; do
        grep -Eq "\"$marker:" "$py" || fail "pyproject.toml lost pytest marker '$marker'"
    done
    for section in '\[tool\.ruff\]' '\[tool\.coverage\]' '\[tool\.pytest\.ini_options\]'; do
        grep -Eq "^$section" "$py" || fail "pyproject.toml lost section $section"
    done
fi

if [[ -f "$DST/.github/workflows/ci.yml" ]]; then
    for job in lint type-check unit-test integration-test security-scan build; do
        grep -Eq "^  $job:" "$DST/.github/workflows/ci.yml" || fail "ci.yml lost required job '$job'"
    done
fi

if [[ -f "$DST/Makefile" ]]; then
    for target in lint format typecheck test coverage; do
        grep -Eq "^$target:" "$DST/Makefile" || fail "Makefile lost target '$target'"
    done
fi

# 4. Customized files must differ from the template and contain no template placeholders.
customized=(
    README.md
    ARCHITECTURE.md
    DECISIONS.md
    LICENSE
    repo-meta/ownership.yaml
    repo-meta/dependencies.yaml
    sdk/REGISTRY.md
)
for rel in "${customized[@]}"; do
    [[ -e "$DST/$rel" ]] || continue
    if cmp -s "$TPL/$rel" "$DST/$rel"; then
        fail "$rel is still the unmodified template"
    fi
done

grep -q '^# Project Name' "$DST/README.md" 2>/dev/null && fail "README.md still has the '# Project Name' placeholder"
grep -q '^# AI-Agent Guidelines' "$DST/README.md" 2>/dev/null || fail "README.md was not merged into the template structure (no '# AI-Agent Guidelines' section)"
grep -Eq '\[year\]|\[fullname\]' "$DST/LICENSE" 2>/dev/null && fail "LICENSE still has [year]/[fullname] placeholders"
grep -q 'example-sdk' "$DST/sdk/REGISTRY.md" 2>/dev/null && fail "sdk/REGISTRY.md still lists example-sdk"

# 5. Agent entry point must keep the knowledge map.
grep -q 'Repository Knowledge Map' "$DST/AGENTS.md" 2>/dev/null || fail "AGENTS.md lost the Repository Knowledge Map section"

# 6. Traceability: the standard version must be recorded as an ADR.
if [[ -n "$SHA" && "$SHA" != "unknown" ]]; then
    grep -q "$SHA" "$DST/DECISIONS.md" 2>/dev/null || fail "DECISIONS.md does not record the standard commit $SHA"
else
    grep -Eq '^## \[ADR-[0-9]+\].*AI-Native Repository Standard' "$DST/DECISIONS.md" 2>/dev/null \
        || fail "DECISIONS.md has no ADR adopting the AI-Native Repository Standard"
fi

# 7. The standard itself must not be inside the target.
if find "$DST" -path "$DST/.git" -prune -o -name 'AI-Native Repository Standard.md' -print | grep -q .; then
    fail "a copy of the standard document is inside the target repository"
fi

# 8. Layer skeleton from the standard's Directory Rules.
for layer in api application domain infrastructure; do
    [[ -d "$DST/src/$layer" ]] || fail "missing layer directory src/$layer"
done
for dir in unit integration e2e fixtures; do
    [[ -d "$DST/tests/$dir" ]] || fail "missing test directory tests/$dir"
done

# 9. Open questions for humans.
todos="$(grep -rn 'TODO(human)' "$DST" --exclude-dir=.git 2>/dev/null | wc -l | tr -d ' ')"
if [[ "$todos" -gt 0 ]]; then
    warn "$todos TODO(human) marker(s) need a human decision:"
    grep -rn 'TODO(human)' "$DST" --exclude-dir=.git | sed "s|^$DST/|      |"
fi

echo
echo "summary: $fails fail(s), $warns warning(s)"
[[ "$fails" -eq 0 ]]
