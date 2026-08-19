# Project and CLI

## Establish the Target

Before changing state, determine whether the task targets:

- A CLI-managed local stack
- A linked managed development, preview, staging, or production project
- A managed project changed directly through the Dashboard
- An official self-hosted deployment

Inspect the repository's `supabase/config.toml`, migrations or declarative schemas, seeds, functions,
generated types, environment examples, CI workflow, and application clients. Establish the project ref,
current link, CLI version, schema state, and rollback or recovery path relevant to the change.

## Current Commands and Documentation

- Run `supabase --version` and discover command syntax through `supabase --help` and nested `--help`.
- Verify version-sensitive behavior against current official Supabase documentation and relevant
  changelog entries. Do not infer flags or config keys from memory.
- Prefer the official Supabase documentation or repository over tutorials and generated snippets.
- If the CLI or required runtime is missing, report the gap before inventing a substitute workflow.

## Mutation Boundaries

- Read-only discovery may inspect status, migration lists, diffs, logs, and configuration.
- A request to edit repository files does not authorize pushing schema, secrets, functions, or config to
  a remote project.
- Use explicit local or linked targeting when a command could affect more than one environment.
- Treat reset, migration repair, seed inclusion, secret rotation, project deletion, and volume deletion as
  separate destructive operations requiring exact target resolution and recovery awareness.

## Environment Differences

The CLI local stack is a development environment, not proof of managed-production behavior. Managed and
self-hosted Supabase differ in upgrades, backups, observability, abuse controls, SMTP, networking, and
operator responsibilities. Load self-hosting-specific documentation only when that is the actual target.

## Check

Report which target and versions were verified, which state was only inferred, and which remote actions
were not performed. Confirm no credentials or connection strings containing passwords entered output.
