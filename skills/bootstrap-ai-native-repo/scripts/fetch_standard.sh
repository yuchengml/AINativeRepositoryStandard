#!/usr/bin/env bash
# Fetch the AI-Native Repository Standard into a directory OUTSIDE the target repository.
#
# Usage: fetch_standard.sh [ref]
#
# Environment:
#   AI_NATIVE_STANDARD_DIR  Use an existing local checkout instead of cloning.
#   AI_NATIVE_STANDARD_URL  Git URL to clone (default: the public standard repository).
#   AI_NATIVE_STANDARD_REF  Branch or tag to clone (overridden by the [ref] argument).
#
# Prints two lines for the caller to capture:
#   STANDARD_DIR=<path>
#   STANDARD_SHA=<commit sha or "unknown">
set -euo pipefail

URL="${AI_NATIVE_STANDARD_URL:-https://github.com/yuchengml/AINativeRepositoryStandard.git}"
REF="${1:-${AI_NATIVE_STANDARD_REF:-}}"

if [[ -n "${AI_NATIVE_STANDARD_DIR:-}" ]]; then
    DIR="$(cd "$AI_NATIVE_STANDARD_DIR" && pwd)"
else
    DIR="$(mktemp -d "${TMPDIR:-/tmp}/ai-native-standard.XXXXXX")"
    if [[ -n "$REF" ]]; then
        git clone --quiet --depth 1 --branch "$REF" "$URL" "$DIR"
    else
        git clone --quiet --depth 1 "$URL" "$DIR"
    fi
fi

if [[ ! -d "$DIR/templates" || ! -f "$DIR/AI-Native Repository Standard.md" ]]; then
    echo "error: $DIR does not look like the AI-Native Repository Standard (missing templates/ or standard document)" >&2
    exit 1
fi

SHA="$(git -C "$DIR" rev-parse HEAD 2>/dev/null || echo unknown)"

echo "STANDARD_DIR=$DIR"
echo "STANDARD_SHA=$SHA"
