#!/usr/bin/env bash
# Print a Markdown CHANGES table skeleton from the diff against a base branch.
# Usage: scripts/changes-table.sh [base]   (base defaults to origin/main)
# Then replace each "<what & why>" with a one-line, why-focused description.
set -euo pipefail
BASE="${1:-origin/main}"

echo "| File | Change |"
echo "|------|--------|"
git diff --name-status "${BASE}...HEAD" | while IFS=$'\t' read -r status file rest; do
  case "$status" in
    A*)  verb="Added" ;;
    M*)  verb="Modified" ;;
    D*)  verb="Deleted" ;;
    R*)  verb="Renamed"; file="${rest:-$file}" ;;
    C*)  verb="Copied";  file="${rest:-$file}" ;;
    *)   verb="$status" ;;
  esac
  echo "| \`${file}\` | ${verb} — <what & why> |"
done
