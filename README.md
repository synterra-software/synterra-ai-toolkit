# Synterra Skills

Shared Claude Code and Codex skills for the Synterra engineering team. One repo, every dev pulls it
once.

## Available skills

### `pr-description`

Creates a pull request description in Synterra's standard WHAT / CHANGES / NOTES / Type format. It
reads the current branch's Git history and diff, builds a Jira link from a `PROJECT-123` key in the
branch name, and summarizes the changed files for reviewers. It does not fetch Jira ticket contents.

Use it when preparing, reviewing, or opening a pull request:

- **Codex:** `$pr-description Create a PR description for my current branch`
- **Claude Code:** `/pr-description Create a PR description for my current branch`
- **Automatic:** Ask `Create a PR description for my current branch` and the agent can select the
  skill from the request.

The skill prints the description by default. It opens a pull request only when you explicitly ask it
to do so.

## Setup (one-time, per dev)

```
git clone <your-org>/synterra-skills ~/synterra-skills
~/synterra-skills/install.sh
```

`install.sh` symlinks each skill from this repo into both agents' user-level skill directories, so
they are available in **every** project on your machine:

- Claude Code: `~/.claude/skills/`
- Codex: `~/.agents/skills/`

Verify with `/skills` in Claude Code or Codex CLI/IDE. In Codex, you can explicitly invoke a skill by
typing `$` followed by its name, for example `$pr-description`. Codex can also select a skill
automatically when your request matches its description. If a newly installed skill does not appear,
restart Codex.

## Updating

```
cd ~/synterra-skills && git pull
```

Because the skills are symlinked, a `git pull` is enough — edits show up immediately.
Only re-run `./install.sh` when a **new** skill folder is added to the repo.

## Notes

- Skills are picked up by **Claude Code** from `~/.claude/skills/` and by **Codex** from
  `~/.agents/skills/`. Skills used via claude.ai on the web are uploaded per-user and are not covered
  by this repo.
- `install.sh` never overwrites a real skill folder in either destination. If you already have a
  skill with the same name, it skips it and warns, so your local skills are safe.

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
