# Synterra Skills

Shared Claude Code and Codex skills for the Synterra engineering team. One repo, every dev pulls it
once.

## Available skills

### `pr-description`

Creates a pull request description in Synterra's standard WHAT / CHANGES / NOTES / Type format. It
reads the current branch's Git history and diff, builds a Jira link from a `PROJECT-123` key in the
branch name, and summarizes the changed files for reviewers. It does not fetch Jira ticket contents.

Use it when preparing or revising pull request content. It returns a title/body; branch management,
commits, pushes, and GitHub publication belong to a separate explicitly authorized workflow.

- **Codex:** `$pr-description Create a PR description for my current branch`
- **Claude Code:** `/pr-description Create a PR description for my current branch`

### `software-engineering`

Guides cross-cutting software work through specification, architectural ownership, reuse, refactoring,
and verification. Use it when those decisions span a framework or product boundary.

- **Codex:** `$software-engineering Plan and implement this change`
- **Claude Code:** `/software-engineering Plan and implement this change`

### `frontend-engineering`

Guides framework-agnostic or cross-cutting frontend architecture while preserving the framework, design
system, dependencies, application shell, and repository conventions.

- **Codex:** `$frontend-engineering Implement this frontend change`
- **Claude Code:** `/frontend-engineering Implement this frontend change`

### `react-engineering`

Provides React and TypeScript rules for components, hooks, modals, forms, state, server data, generated
API clients, and refactoring. It loads only the references relevant to the requested React change.

- **Codex:** `$react-engineering Implement this React change`
- **Claude Code:** `/react-engineering Implement this React change`

### `nextjs-engineering`

Provides Next.js-specific guidance for App Router and Pages Router, React Server Components, SSR,
SSG, ISR, Cache Components and PPR, data fetching, Server Actions, Route Handlers, routing, runtimes,
and deployment. It loads only the references relevant to the requested Next.js behavior.

- **Codex:** `$nextjs-engineering Implement this Next.js change`
- **Claude Code:** `/nextjs-engineering Implement this Next.js change`

### `backend-engineering`

Guides framework-agnostic or cross-cutting backend architecture across services, APIs, workers,
integrations, persistence, reliability, and operations while preserving the existing runtime and
deployment model.

- **Codex:** `$backend-engineering Implement this backend change`
- **Claude Code:** `/backend-engineering Implement this backend change`

### `nestjs-engineering`

Provides NestJS and TypeScript rules for modules, dependency injection, transport boundaries, DTOs,
guards, persistence, queues, lifecycle, security, and testing. It loads only the references relevant
to the requested NestJS change.

- **Codex:** `$nestjs-engineering Implement this NestJS change`
- **Claude Code:** `/nestjs-engineering Implement this NestJS change`

### `supabase-engineering`

Provides Supabase-specific guidance for Postgres schema and migrations, generated types, RLS, Auth and
SSR, Storage, Realtime, Edge Functions, local development, deployment, and troubleshooting. It loads
only the references relevant to the active Supabase product or workflow.

- **Codex:** `$supabase-engineering Implement this Supabase change`
- **Claude Code:** `/supabase-engineering Implement this Supabase change`

All eight skills can also activate automatically when a request matches their descriptions. Explicit
invocation is useful when you want to guarantee that a particular workflow is loaded.

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

- Load the most specific matching skill for the task; do not automatically load its entire domain stack.
- Use `software-engineering` for cross-cutting specification, architecture, ownership, reuse, or refactoring.
- Use `frontend-engineering` for framework-agnostic or cross-cutting frontend architecture.
- Use `react-engineering` for React components, hooks, forms, modals, and client/server-state integration.
- Use `nextjs-engineering` for Next.js routing, rendering, caching, RSC, actions, runtimes, and deployment.
- Use `backend-engineering` for framework-agnostic or cross-cutting backend architecture.
- Use `nestjs-engineering` for NestJS-specific implementation and `supabase-engineering` for Supabase work.
- Combine skills only when the requested change genuinely crosses their boundaries.
- When preparing, opening, or updating a pull request, load and follow `pr-description`.
- Treat the matching skill requirements as mandatory repository instructions.
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
cd <path-to-synterra-ai-toolkit> && git pull
```

Plugin installs update with `/plugin marketplace update`.
Symlinked skills receive updates immediately after `git pull`. Copied skills must be copied again.
Claude Code users only need to re-run `./install.sh` when a **new** skill folder is added.

## Notes

- Skills are picked up by **Claude Code** from `~/.claude/skills/` and by **Codex** from
  `~/.agents/skills/`. Skills used via claude.ai on the web are uploaded per-user and are not covered
  by this repo.
- `install.sh` never overwrites a real skill folder in either destination. If you already have a
  skill with the same name, it skips it and warns, so your local skills are safe.

## Layout

```
synterra-ai-toolkit/
├── .claude-plugin/        # plugin + marketplace manifests
├── install.sh
└── skills/
    ├── pr-description/
    ├── software-engineering/
    ├── frontend-engineering/
    ├── react-engineering/
    ├── nextjs-engineering/
    ├── backend-engineering/
    ├── nestjs-engineering/
    └── supabase-engineering/
```

Each skill folder contains `SKILL.md` plus optional `references/` and `scripts/`.

Add a new shared skill by dropping another folder under `skills/` and bumping the plugin version
in `.claude-plugin/` so plugin users receive it.
