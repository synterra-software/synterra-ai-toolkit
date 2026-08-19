# Testing and Operations

## Local Verification

- Prefer a reproducible local Supabase stack for schema, policy, function, and integration work when the
  repository supports it.
- Replay migrations and seeds from an empty disposable local database. Treat reset as destructive to that
  local database and never redirect it to a linked environment.
- Run database tests and advisors already configured by the project. Add policy tests for allowed and
  denied roles instead of verifying only through an admin connection.
- Regenerate types and run application tests, strict types, lint, and build after contract changes.

## Product-Level Checks

- Database: representative queries, constraints, RLS, grants, and RPC behavior
- Auth: identity verification, refresh, callbacks, sign-out, and protected access
- Storage: bucket and object policy, upload or download, signed URLs, and cleanup
- Realtime: connection, filtered delivery, authorization, reconnection, and unsubscribe
- Edge Functions: invocation, auth, validation, dependency failure, secrets, and logs

## Deployment

- Compare local and remote migration history and review the exact deployment target.
- Use preview or staging environments when available for migration and end-to-end verification.
- A user request to change repository files is not authorization to push migrations, functions, secrets,
  or configuration to Supabase.
- For destructive or hard-to-reverse changes, define backups, rollback or forward-fix, and restore evidence
  before execution.

## Diagnosis

Use the current Supabase monitoring and debugging documentation to select the relevant logs for Database,
API, Auth, Storage, Realtime, or Edge Functions. Correlate logs with the failing request or operation;
do not paste credentials, tokens, full sensitive payloads, or password-bearing connection strings.

## Exit Criteria

The changed boundary works with realistic credentials and roles, migrations replay, generated artifacts
match the schema, denial paths are proven, and no secret material appears in code, logs, or the handoff.
