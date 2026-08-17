# Synterra Skills

Shared agent skills for the Synterra engineering team. One repo, every dev pulls it once.

## Skills

- **pr-description**: generates PR descriptions in the standard WHAT / CHANGES / NOTES / Type format.
- **add-pr-ui-screenshots**: captures changed UI and adds GitHub-hosted screenshots to an existing
  PR description.
- **software-engineering**: guides specification, ownership, implementation, and verification decisions.
- **frontend-engineering**: applies those decisions to frontend work using the existing framework and stack.
- **react-engineering**: standardizes React modals, forms, state ownership, optimistic updates, and generated API boundaries.

## Install as a Claude Code plugin (recommended)

Inside Claude Code run:

```
/plugin marketplace add synterra-software/synterra-ai-toolkit
/plugin install synterra-dev@synterra-marketplace
```

All skills ship with the plugin; updates arrive via `/plugin marketplace update`.

To roll the plugin out to a whole team, commit this to each product repository's
`.claude/settings.json`. Members are prompted to install it when they trust the folder:

```json
{
  "extraKnownMarketplaces": {
    "synterra-marketplace": {
      "source": { "source": "github", "repo": "synterra-software/synterra-ai-toolkit" }
    }
  },
  "enabledPlugins": { "synterra-dev@synterra-marketplace": true }
}
```

## Automatic repository installation

For agents without Claude Code plugin support (Codex and other Agent Skills runtimes), open the
target repository in your coding agent, then copy and paste this entire prompt:

```text
Install the Synterra AI Toolkit into the repository you are currently working in.

Source repository:
https://github.com/synterra-software/synterra-ai-toolkit.git

Perform the installation now. Do not only describe the steps. Ask a question only if authentication,
permissions, or a conflicting existing skill prevents a safe installation.

Requirements:

1. Read the current repository instructions and inspect `git status` before changing anything. Preserve
   all existing work and unrelated files.
2. Resolve the target repository root with `git rev-parse --show-toplevel`. Stop and report clearly if
   the current directory is not inside a Git repository.
3. Clone the source repository with the currently configured Git credentials into a uniquely named
   temporary directory outside the target repository. Use a shallow clone when possible. Do not request,
   print, or copy credentials. If HTTPS authentication fails and configured SSH access is available, use
   `git@github.com:synterra-software/synterra-ai-toolkit.git`.
4. Install every direct child directory under the source `skills/` directory, including all references,
   scripts, and file permissions:
   - Copy each complete skill directory to `<target-repo>/.agents/skills/<skill-name>` for Codex and
     Agent Skills compatible agents.
   - Copy each complete skill directory to `<target-repo>/.claude/skills/<skill-name>` for Claude Code.
   - If the current agent requires another documented project-level Agent Skills directory, install the
     same complete skill directories there too.
   - If a destination does not exist, create it. If it is identical to the source, leave it unchanged. If
     it exists and differs, do not overwrite it: report the conflict and ask before replacing anything.
5. Ensure repository agents are explicitly required to use the installed skills:
   - Update or create the root `AGENTS.md` without removing or rewriting existing instructions.
   - Update or create the root `CLAUDE.md` unless it already imports the root `AGENTS.md`.
   - If the current agent reads neither file, update its documented repository instruction file too.
   - Add the following marked block exactly once. If the markers already exist, update that block in place.

<!-- synterra-ai-toolkit:start -->
## Synterra engineering skills

- Before planning, implementing, reviewing, or changing software, load and follow the
  `software-engineering` skill.
- For frontend application work, load and follow both `software-engineering` and
  `frontend-engineering`.
- For React application work, also load and follow `react-engineering`.
- When preparing, opening, or updating a pull request, load and follow `pr-description`.
- Treat these skill requirements as mandatory repository instructions.
<!-- synterra-ai-toolkit:end -->

6. Clean up only the temporary source directory created for this installation.
7. Verify the result:
   - Every installed skill directory contains a valid `SKILL.md` with `name` and `description`.
   - Supporting references and scripts were copied, local Markdown links resolve, and executable scripts
     remain executable.
   - The marked instruction block appears exactly once in every applicable instruction file.
   - List the installed skill names and print the final changed file tree plus `git status --short`.
   - Mention that the agent may need to restart or open a new session if newly created skill directories
     are not detected immediately.

Do not modify the downloaded skill contents, install dependencies, commit, push, or open a pull request.
Finish by summarizing what was installed, which instruction files were updated, and any conflicts or
manual follow-up required.
```

## Manual setup (one-time, per dev)

```
git clone https://github.com/synterra-software/synterra-ai-toolkit.git
cd synterra-ai-toolkit
```

Install each folder under `skills/` in your agent's user-level skills directory. Link the folder to
receive repository updates automatically, or copy it if your agent does not support linked skill
directories. Agents use different paths and verification commands, so follow your agent's skill
installation documentation.

### Claude Code helper

Claude Code users can run:

```
./install.sh
```

This symlinks each skill into `~/.claude/skills/`. Verify the installation with `/skills` inside
Claude Code.

## Updating

```
cd <path-to-synterra-ai-toolkit> && git pull
```

Plugin installs update with `/plugin marketplace update`.
Symlinked skills receive updates immediately after `git pull`. Copied skills must be copied again.
Claude Code users only need to re-run `./install.sh` when a **new** skill folder is added.

## Notes

- Skill discovery paths and commands vary by agent. Consult your agent's documentation when adding
  or verifying skills.
- `install.sh` configures Claude Code only. It never overwrites a real folder in
  `~/.claude/skills/`: if you already have a skill
  with the same name, it skips it and warns, so your local skills are safe.
- The `pr-description` skill builds the Jira link from the branch name (`PROJECT-XXX`) and asks you for
  the summary. It does not fetch ticket contents.

## Layout

```
synterra-ai-toolkit/
├── .claude-plugin/        # plugin + marketplace manifests
├── install.sh
└── skills/
    ├── add-pr-ui-screenshots/
    ├── pr-description/
    ├── software-engineering/
    ├── frontend-engineering/
    └── react-engineering/
```

Each skill folder contains `SKILL.md` plus optional `references/` and `scripts/`.

Add a new shared skill by dropping another folder under `skills/` and bumping the plugin version
in `.claude-plugin/` so plugin users receive it.
