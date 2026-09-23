#!/usr/bin/env bash
# Copy every file under <standard_dir>/templates/ into <target_dir> without overwriting anything.
#
# Usage: copy_templates.sh <standard_dir> <target_dir>
#
# Existing files in the target (e.g. the initial README.md project brief) are never overwritten.
# They are listed as CONFLICT so the agent can merge them by hand against the template in
# <standard_dir>/templates/<path>.
set -euo pipefail

if [[ $# -ne 2 ]]; then
    echo "usage: $0 <standard_dir> <target_dir>" >&2
    exit 2
fi

SRC="$(cd "$1/templates" && pwd)"
DST="$(cd "$2" && pwd)"

# The standard copy must live outside the target so it can never be committed by accident.
case "$(cd "$1" && pwd)/" in
    "$DST"/*)
        echo "error: standard directory is inside the target repository; move it outside first" >&2
        exit 1
        ;;
esac

copied=0
conflicts=()

while IFS= read -r -d '' file; do
    rel="${file#"$SRC"/}"
    dest="$DST/$rel"
    if [[ -e "$dest" ]]; then
        conflicts+=("$rel")
        continue
    fi
    mkdir -p "$(dirname "$dest")"
    cp -p "$file" "$dest"
    copied=$((copied + 1))
done < <(find "$SRC" -type f -print0 | sort -z)

echo "copied: $copied file(s)"
if [[ ${#conflicts[@]} -gt 0 ]]; then
    for rel in "${conflicts[@]}"; do
        echo "CONFLICT: $rel (kept existing; template at $SRC/$rel)"
    done
fi
