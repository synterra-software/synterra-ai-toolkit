---
name: supabase-engineering
description: Use for Supabase-specific Database, Auth, RLS, migrations, generated types, Storage, Realtime, Edge Functions, SSR clients, CLI workflows, local development, deployment, and troubleshooting. Add frontend or backend skills only when work extends beyond the Supabase boundary.
---

# Supabase Engineering

Preserve the project's existing schema workflow, client boundaries, framework integration, and deployment
model. For browser or framework integration, inspect the matching framework conventions without loading
unrelated frontend or backend guidance.

## Read Before Work

- Managed, local, linked, or self-hosted target; CLI and documentation lookup: [Project and CLI](references/project-and-cli.md)
- Tables, functions, migrations, generated types, indexes, pooling: [Database and Migrations](references/database-and-migrations.md)
- RLS, grants, views, privileged functions, keys, tenant isolation: [RLS and Security](references/rls-and-security.md)
- Browser/server clients, sessions, cookies, SSR, identity checks: [Auth and SSR](references/auth-and-ssr.md)
- Buckets, objects, subscriptions, functions, secrets, webhooks: [Storage, Realtime, and Functions](references/storage-realtime-and-functions.md)
- Local replay, policy tests, deployment checks, logs, recovery: [Testing and Operations](references/testing-and-operations.md)

Read every matching reference.

## Non-Negotiable

- Supabase changes frequently. Check the installed CLI or SDK version and current official documentation
  before relying on commands, configuration keys, or auth behavior.
- Identify the exact target before mutation. Distinguish local, linked preview or staging, production, and
  self-hosted environments; do not let an ambiguous command choose the database.
- Keep schema and policy changes reproducible through the repository's declarative schema or migration
  workflow. Review generated SQL and never edit an applied migration.
- Enable RLS and least-privilege grants for tables exposed through the Data API. Test both allowed and
  denied cases with the same roles and claims used by the application.
- Publishable keys may be used by public clients only with correct grants and RLS. Secret and service-role
  keys are server-only, bypass RLS, and must never appear in browser bundles, logs, examples, or commits.
- Keep public, user-session, and privileged admin clients separate. Do not use a service-role response as
  evidence that user authorization works.
- Generate database client types from the schema after relevant changes; never hand-edit generated types.
- Preserve Postgres constraints, transaction boundaries, query bounds, and index requirements beneath
  the Supabase APIs.
- Verify the changed product boundary: database, Auth, Storage, Realtime, or Edge Functions. A successful
  deployment or healthy container alone is insufficient.

## Check

Run the repository's relevant Supabase CLI, database, type-generation, application, and contract checks.
Replay migrations locally when schema changes, exercise negative RLS or Storage cases, and inspect the
relevant service logs when runtime behavior remains unexplained.
