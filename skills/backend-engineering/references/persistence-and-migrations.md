# Persistence and Migrations

## Data Ownership

- Identify the authoritative owner of each record and invariant before changing storage or write paths.
- Keep database and ORM details behind the project's existing persistence boundary; do not add a
  repository layer only for ceremony.
- Fetch bounded data and select only what the operation needs. Check query plans for changed hot paths.
- Prevent N+1 access and accidental unbounded scans using the installed ORM or query tooling.

## Transactions and Concurrency

- Define the atomic unit around business invariants, not around individual repository calls.
- Keep remote network calls outside database transactions unless the established design explicitly
  coordinates them.
- Choose optimistic checks, locks, uniqueness constraints, idempotency keys, or serialization based on
  the actual contention and correctness requirement.
- Back invariants with database constraints where the database can enforce them.
- Test duplicate, stale, and concurrent attempts for correctness-sensitive writes.

## Schema Changes

- Use the repository's migration tool and naming conventions. Never edit an applied migration.
- Prefer expand-and-contract changes for mixed-version deployments: add compatible schema, deploy
  compatible code, backfill safely, switch reads or writes, then remove obsolete schema later.
- Make backfills restartable, observable, bounded, and safe under concurrent application writes.
- Avoid long blocking operations on production tables; use database-supported online or staged methods.
- Define rollback or forward-fix behavior before destructive or irreversible changes.

## Check

Run migration validation on a representative database, verify upgrade from the currently deployed
schema, and exercise affected reads and writes. For risky changes, inspect locks, query plans, timing,
and the mixed-version deployment window.
