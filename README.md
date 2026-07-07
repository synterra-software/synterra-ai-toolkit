# Synterra Skills

Shared Claude Code skills for the Synterra engineering team. One repo, every dev pulls it once.

## Skills

- **pr-description** — generates PR descriptions in the standard WHAT / CHANGES / NOTES / Type format.

## Setup (one-time, per dev)

```
git clone <your-org>/synterra-skills ~/.claude/synterra-skills
~/.claude/synterra-skills/install.sh
```

`install.sh` symlinks each skill from this repo into `~/.claude/skills/`, so Claude Code sees them
in **every** project on your machine. Verify with `/skills` inside Claude Code.

## Updating

```
cd ~/.claude/synterra-skills && git pull
```

Because the skills are symlinked, a `git pull` is enough — edits show up immediately.
Only re-run `./install.sh` when a **new** skill folder is added to the repo.

## Notes

- Skills are picked up by **Claude Code**, from `~/.claude/skills/`. (Skills used via claude.ai on the
  web are uploaded per-user and are not covered by this repo.)
- `install.sh` never overwrites a real folder in `~/.claude/skills/` — if you already have a skill
  with the same name, it skips it and warns, so your local skills are safe.
- The `pr-description` skill builds the Jira link from the branch name (`PROJECT-XXX`) and asks you for
  the summary. It does not fetch ticket contents.

## Layout

```
synterra-skills/
├── install.sh
└── skills/
    └── pr-description/
        ├── SKILL.md
        └── scripts/
            └── changes-table.sh
```

Add a new shared skill by dropping another folder under `skills/` and committing it.
# synterra-ai-toolkit
