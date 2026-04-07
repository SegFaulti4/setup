#!/usr/bin/env bash
set -euo pipefail

FILE="0-apt-packages.txt"

if [[ ! -f "$FILE" ]]; then
  echo "No $FILE found, error."
  exit 1
fi

tmp=$(mktemp)
grep -v '^\s*$' "$FILE" | sort -u > "$tmp"

if ! cmp -s "$FILE" "$tmp"; then
  mv "$tmp" "$FILE"
  echo "Sorted $FILE"
else
  rm "$tmp"
fi
