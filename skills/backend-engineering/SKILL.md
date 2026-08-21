---
name: backend-engineering
description: Always use for any backend work — services, APIs, workers, integrations, service boundaries, contracts, persistence, migrations, background work, reliability, and operations. Load it together with `software-engineering`, and load `nestjs-engineering` and `supabase-engineering` on top whenever those technologies are involved.
---

# Backend Engineering

Apply `software-engineering` first, then this skill for every backend change. Preserve the runtime,
framework, service boundaries, contracts, data ownership, and deployment model. Always load the matching
technology skill on top when the work touches NestJS, Supabase, or another backend platform — this skill
does not replace it.

## Before Implementation

- Inspect the runtime, framework, module boundaries, transports, public contracts, data model,
  migrations, authentication, configuration, background work, observability, and deployment model.
- Trace the complete request or event path, including authorization, persistence, external calls,
  retries, partial failure, and recovery.
- Identify compatibility, data-integrity, security, and operational risks before changing a contract,
  schema, transaction boundary, or shared runtime behavior.
- Do not replace working architecture without a concrete requirement.

## Read when relevant

- Platform, shared-capability, or product ownership: [Backend Boundaries](references/backend-boundaries.md)
- HTTP, GraphQL, RPC, event, or webhook contracts: [API and Message Contracts](references/api-and-message-contracts.md)
- Database access, transactions, schema, or migrations: [Persistence and Migrations](references/persistence-and-migrations.md)
- External calls, jobs, retries, observability, or deployment lifecycle: [Reliability and Operations](references/reliability-and-operations.md)

## Implementation

- Keep dependencies directional and make ownership of business rules, data, and side effects explicit.
- Validate and authorize at trusted boundaries; keep domain behavior independent of transport details.
- Preserve public contract compatibility unless a breaking change and migration path are requested.
- Define transaction and concurrency behavior for multi-step state changes.
- Bound queries, external calls, retries, queues, and resource use. Retry only operations that are safe
  to repeat or protected by idempotency.
- Keep secrets out of source, logs, errors, and responses. Use the existing configuration boundary.
- Add observability where operators need to diagnose the changed behavior, without logging sensitive data.
- Make the smallest coherent change that fits the existing runtime and deployment model.

## Verification

- Verify the primary flow, authorization, validation, state transitions, failure behavior, and contract.
- Test transaction boundaries, concurrency, retries, and migration compatibility when affected.
- Run the repository checks relevant to the changed service and exercise real integration boundaries
  where mocks would hide contract or wiring failures.
- Confirm ownership, compatibility, and operational assumptions still match the implemented behavior.
