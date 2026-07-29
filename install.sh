#!/usr/bin/env bash
# Link every skill in this repo into the user skill directories used by Claude Code
# and Codex so both agents pick them up globally (in all projects). Safe to re-run;
# only touches symlinks it owns.
#
# One-time per machine:   ./install.sh
# To update later:        git pull   (symlinks see the new content automatically)
#                         re-run ./install.sh only when NEW skills are added.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO_DIR/skills"

shopt -s nullglob

link_skills() {
  local agent="$1"
  local dest="$2"
  local linked=0
  local skill name target link

  mkdir -p "$dest"

  for skill in "$SRC"/*/; do
    name="$(basename "$skill")"
    target="${skill%/}"
    link="$dest/$name"

    if [ -L "$link" ]; then
      rm -f "$link"                 # re-point an existing symlink
    elif [ -e "$link" ]; then
      echo "SKIP  [$agent] $name — $link exists and is a real file/dir, not touching it" >&2
      continue
    fi

    ln -s "$target" "$link"
    echo "LINK  [$agent] $name -> $link"
    linked=$((linked + 1))
  done

  echo "$agent: linked $linked skill(s)."
}

link_skills "Claude Code" "$HOME/.claude/skills"
link_skills "Codex" "$HOME/.agents/skills"

echo "Done. Run '/skills' in Claude Code or Codex CLI/IDE to verify."
