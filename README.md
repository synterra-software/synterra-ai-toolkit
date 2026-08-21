# Synterra Skills

Shared Claude Code and Codex skills for the Synterra engineering team, distributed as a plugin.

## Available skills

### `pr-description`

Creates a pull request description in Synterra's standard WHAT / CHANGES / NOTES / Type format. It
reads the current branch's Git history and diff, builds a Jira link from a `PROJECT-123` key in the
branch name, and summarizes the changed files for reviewers. It does not fetch Jira ticket contents.

It runs automatically before any action that creates or updates a pull request — `gh pr create`, "open
a PR", or finishing work on a feature branch — so no PR is opened with an ad-hoc body. When the work is
still on `main`, it also creates the branch using the team convention
`<type>/<PROJECT-XXX>-<short-description>` (for example `feature/PROJ-412-upload-retry`). The Jira key is
mandatory — the skill asks for it rather than guessing — and only a `hotfix` may ship without one. Commits
and pushes stay outside the skill.

- **Codex:** `$pr-description Create a PR description for my current branch`
- **Claude Code:** `/pr-description Create a PR description for my current branch`

### `software-engineering`

Guides all software work through specification, architectural ownership, reuse, refactoring, and
verification. Load it for every engineering task, then stack the matching domain and framework skills
on top.

- **Codex:** `$software-engineering Plan and implement this change`
- **Claude Code:** `/software-engineering Plan and implement this change`

### `frontend-engineering`

Guides frontend architecture — application shell, routing, design system, state, data access,
accessibility, and performance — while preserving the existing framework, dependencies, and repository
conventions. Use it together with `software-engineering` for all frontend work.

- **Codex:** `$frontend-engineering Implement this frontend change`
- **Claude Code:** `/frontend-engineering Implement this frontend change`

### `react-engineering`

Provides React and TypeScript rules for components, hooks, modals, forms, state, server data, generated
API clients, and refactoring. Use it together with `software-engineering` and `frontend-engineering`
for all React work; it loads the reference files relevant to the requested change.

- **Codex:** `$react-engineering Implement this React change`
- **Claude Code:** `/react-engineering Implement this React change`

### `nextjs-engineering`

Provides Next.js-specific guidance for App Router and Pages Router, React Server Components, SSR,
SSG, ISR, Cache Components and PPR, data fetching, Server Actions, Route Handlers, routing, runtimes,
and deployment. Use it together with `software-engineering`, `frontend-engineering`, and
`react-engineering` for all Next.js work; it loads only the references relevant to the task.

- **Codex:** `$nextjs-engineering Implement this Next.js change`
- **Claude Code:** `/nextjs-engineering Implement this Next.js change`

### `backend-engineering`

Guides backend architecture across services, APIs, workers, integrations, persistence, migrations,
reliability, and operations while preserving the existing runtime, contracts, and deployment model. Use
it together with `software-engineering` for all backend work.

- **Codex:** `$backend-engineering Implement this backend change`
- **Claude Code:** `/backend-engineering Implement this backend change`

### `nestjs-engineering`

Provides NestJS and TypeScript rules for modules, dependency injection, transport boundaries, DTOs,
guards, persistence, queues, lifecycle, security, and testing. Use it together with
`software-engineering` and `backend-engineering`; it loads only the references relevant to the task.

- **Codex:** `$nestjs-engineering Implement this NestJS change`
- **Claude Code:** `/nestjs-engineering Implement this NestJS change`

### `supabase-engineering`

Provides Supabase-specific guidance for Postgres schema and migrations, generated types, RLS, Auth and
SSR, Storage, Realtime, Edge Functions, local development, deployment, and troubleshooting. Use it
together with `software-engineering` and `backend-engineering`; it loads only the references relevant to
the active Supabase product or workflow.

- **Codex:** `$supabase-engineering Implement this Supabase change`
- **Claude Code:** `/supabase-engineering Implement this Supabase change`

All eight skills activate automatically whenever a request falls in their area, and they stack rather
than compete: `software-engineering` applies to every change, the frontend or backend skill applies to
its side of the stack, and the framework skills apply on top. Explicit invocation is useful when you want
to guarantee that a particular workflow is loaded.

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

## Install as a Codex plugin (recommended)

```bash
codex plugin marketplace add synterra-software/synterra-ai-toolkit --ref main
codex plugin add synterra-dev@synterra-marketplace
```

Codex downloads and caches the plugin from GitHub; no local toolkit clone or skill symlinks are needed.
Start a new Codex task after the first installation so the skills are discovered.

## Updating

Claude Code:

```
/plugin marketplace update synterra-marketplace
```

Codex:

```bash
codex plugin marketplace upgrade synterra-marketplace
codex plugin add synterra-dev@synterra-marketplace
```

## Notes

- Explicitly invoke a skill by typing `$` followed by its name in Codex or `/` followed by its name
  in Claude Code. Both agents can also select a skill automatically when a request matches its
  description.
- Skills used via claude.ai on the web are uploaded per-user and are not covered by this repository.

## Layout

```
synterra-ai-toolkit/
├── .agents/plugins/       # Codex marketplace manifest
├── .claude-plugin/        # plugin + marketplace manifests
├── .codex-plugin/         # Codex plugin manifest
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

Add a new shared skill under `skills/` and bump the version in both plugin manifests and the Claude
Code marketplace entry so plugin users receive it.
