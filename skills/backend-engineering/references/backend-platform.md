# Backend Platform

## Purpose

Define stable backend foundations shared across capabilities and product areas.

## Responsibilities

Backend platform responsibilities may include:

- Runtime bootstrap, process lifecycle, configuration, secrets, and dependency wiring
- Transport setup for HTTP, GraphQL, RPC, events, queues, and scheduled work
- Authentication primitives and policy enforcement infrastructure
- Database connections, transaction infrastructure, migration tooling, and shared data conventions
- Logging, metrics, tracing, correlation context, health, and readiness
- Timeouts, resource limits, graceful shutdown, and deployment integration
- Testing infrastructure, service harnesses, contract verification, and local development support
- Stable extension points used by multiple capabilities or product areas

These are platform concerns only when they provide a broadly shared foundation rather than serve one
feature flow.

## When Platform Changes Are Justified

Change the platform when multiple current capabilities or product areas need the same stable foundation
and existing extension points cannot support them cleanly. Define affected consumers, compatibility,
rollout, rollback, and broad verification before changing it.

Avoid global middleware, base classes, shared repositories, or process-wide state for one feature's
convenience.

## Extension Points

Prefer narrow contracts with explicit lifecycle, failure, and ownership semantics. Keep domain policy
outside platform adapters. Preserve the runtime and framework's established extension mechanisms.

## Common Failure Modes

- Moving feature-specific policy into global middleware or shared infrastructure.
- Introducing request-global state when explicit data flow is sufficient.
- Replacing framework lifecycle or dependency injection without a concrete limitation.
- Changing shared error, auth, database, or telemetry behavior without validating every consumer.
- Adding infrastructure that has no current operator or product requirement.
