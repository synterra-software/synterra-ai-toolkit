# Backend Boundaries

Use the most specific ownership level that satisfies current requirements.

## Product

Keep domain models, business rules, authorization policy, workflows, persistence decisions, and provider
mapping with the feature that owns their language, data, and failure semantics. Controllers, consumers, and
schedules should translate their boundary and delegate product decisions.

## Capability

Extract a backend capability only when multiple real scenarios share meaning, behavior, and a stable
contract with understood variation. Authentication, notifications, payments, imports, reporting, webhooks,
and background workflows may qualify, but shared code or a shared table alone does not.

Express variation through typed inputs, policies, schemas, adapters, handlers, events, or composition. Make
data ownership, side effects, consistency, and failure behavior explicit. Do not hide differing domain
semantics behind flags or generic integration wrappers.

## Platform

Treat runtime bootstrap, transport setup, dependency wiring, configuration, auth primitives, database and
queue infrastructure, telemetry, health, shutdown, testing harnesses, and stable extension points as platform
only when multiple current capabilities or product areas depend on them.

Platform changes require compatibility, rollout and rollback expectations, and broad verification. Avoid
global middleware, base classes, shared repositories, or process-wide state for one feature's convenience.

## Check

Confirm the change is owned by the narrowest viable level, domain policy remains outside infrastructure,
and any shared contract is supported by current consumers rather than hypothetical reuse.
