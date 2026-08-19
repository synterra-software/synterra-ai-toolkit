---
name: backend-engineering
description: Use when planning, architecting, implementing, or reviewing backend services, APIs, workers, integrations, data access, or migrations within an existing runtime, framework, database, and deployment environment.
---

# Backend Engineering

## Purpose

Apply sound software engineering decisions to backend work while preserving the service architecture,
contracts, data ownership, and operational environment already in place.

## Relationship to Software Engineering

Apply the `software-engineering` skill first for outcome definition, specification depth, ownership,
implementation scope, and verification. This skill adds backend-specific decisions without redefining
that guidance.

## Before Implementation

- Inspect the runtime, framework, module boundaries, transports, public contracts, data model,
  migrations, authentication, configuration, background work, observability, and deployment model.
- Trace the complete request or event path, including authorization, persistence, external calls,
  retries, partial failure, and recovery.
- Identify compatibility, data-integrity, security, and operational risks before changing a contract,
  schema, transaction boundary, or shared runtime behavior.
- Do not replace working architecture without a concrete requirement.

## Backend Ownership Model

Keep domain rules and feature workflows in product code. Reuse capabilities for recurring backend
behavior with understood variation. Change the platform only for stable foundations shared across
multiple capabilities or product areas.

## Reuse Order

Use the first option that cleanly satisfies the requirement:

1. Existing project implementation
2. Existing service or shared module
3. Framework-native capability
4. Existing project dependency
5. Mature ecosystem library
6. Small custom implementation

A more specific skill, such as `nestjs-engineering`, may add framework-specific constraints.

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

## References

- [Backend Platform](references/backend-platform.md)
- [Backend Capabilities](references/backend-capabilities.md)
- [Backend Product Composition](references/backend-product-composition.md)
- [API and Message Contracts](references/api-and-message-contracts.md)
- [Persistence and Migrations](references/persistence-and-migrations.md)
- [Reliability and Operations](references/reliability-and-operations.md)
