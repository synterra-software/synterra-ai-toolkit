# Synterra Skills

Shared Claude Code and Codex skills for the Synterra engineering team, distributed as a plugin.

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
