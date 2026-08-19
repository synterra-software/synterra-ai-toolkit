# Database and Migrations

Apply the backend persistence and migration rules first.

## Schema Source of Truth

- If `supabase/schemas/` or configured schema paths exist, edit the declarative desired state and generate
  a migration with the project's established workflow.
- Otherwise create a new imperative migration through the installed CLI and write the intended SQL there.
- Treat Dashboard or direct SQL changes as potential drift until captured and reviewed in version control.
- Review generated diffs: schema diff tools may miss data changes, policy renames, privileges, and other
  objects. Add required SQL deliberately.
- Never edit a migration that has already been applied to a shared environment.

## Postgres Correctness

- Use constraints for enforceable invariants, foreign keys for ownership, and indexes for foreign keys,
  policy predicates, joins, filters, and ordering used on real paths.
- Keep transactions short and align them with business invariants. Do not hide remote network work inside
  a database transaction.
- Bound result sets and batch sizes. Inspect query plans for changed hot paths and avoid N+1 access.
- Choose direct, session-pooled, or transaction-pooled connections based on the runtime and installed
  driver. Verify prepared-statement compatibility instead of assuming a port or connection string.

## Types and Consumers

- Regenerate client types from the authoritative local or linked schema after schema changes using the
  repository's existing command.
- Never hand-edit generated database types. Update their source schema and regenerate.
- Update RPC arguments, response mappings, application queries, fixtures, and seeds that depend on the
  changed contract.

## Replay and Deployment

Replay the complete migration chain and seeds against a disposable local database. Review the remote
migration list and dry-run capability before a user-authorized push. Do not include development seed data
in production unless that is an explicit, reviewed deployment requirement.

## Check

Verify migration replay, generated types, constraints, representative queries, and mixed-version
compatibility. For material changes, inspect locks and rollout or backfill behavior.
