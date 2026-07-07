#!/usr/bin/env bash
# Link every skill in this repo into ~/.claude/skills so Claude Code picks them up
# globally (in all your projects). Safe to re-run; only touches symlinks it owns.
#
# One-time per machine:   ./install.sh
# To update later:        git pull   (symlinks see the new content automatically)
#                         re-run ./install.sh only when NEW skills are added.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO_DIR/skills"
DEST="$HOME/.claude/skills"

mkdir -p "$DEST"

shopt -s nullglob
linked=0
for skill in "$SRC"/*/; do
  name="$(basename "$skill")"
  target="${skill%/}"
  link="$DEST/$name"

  if [ -L "$link" ]; then
    rm -f "$link"                 # re-point an existing symlink
  elif [ -e "$link" ]; then
    echo "SKIP  $name — $link exists and is a real file/dir, not touching it" >&2
    continue
  fi

  ln -s "$target" "$link"
  echo "LINK  $name -> $link"
  linked=$((linked + 1))
done

echo "Done. Linked $linked skill(s). Run '/skills' in Claude Code to verify."
