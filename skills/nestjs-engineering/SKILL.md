---
name: nestjs-engineering
description: Always use for any NestJS work — modules, controllers, providers, dependency injection, DTOs, pipes, guards, interceptors, filters, persistence wiring, queues, lifecycle, configuration, and testing. Load it together with `software-engineering` and `backend-engineering`.
---

# NestJS Engineering

Apply `software-engineering` and `backend-engineering` first, then this skill for every NestJS change.
Preserve the installed NestJS version, HTTP adapter, transport, ORM, contract tooling, test stack, and
repository conventions.

## Read Before Work

- Modules, providers, dependency injection, scopes, circular dependencies: [Architecture and DI](references/architecture-and-di.md)
- Controllers, DTOs, pipes, guards, interceptors, filters, HTTP, GraphQL, RPC: [Transport Boundaries](references/transport-boundaries.md)
- ORM, repositories, queries, transactions, migrations: [Persistence](references/persistence.md)
- Queues, events, schedules, webhooks, external calls, lifecycle: [Async Work and Lifecycle](references/async-work-and-lifecycle.md)
- Authentication, authorization, secrets, sensitive output: [Security](references/security.md)
- Unit, module, integration, and end-to-end tests: [Testing](references/testing.md)

Read every matching reference.

## Non-Negotiable

- Organize behavior in cohesive feature modules and export only the providers that form a real public
  module contract.
- Let Nest own provider construction. Use constructor injection and preserve explicit injection tokens.
- Keep controllers and transport handlers focused on protocol translation; keep product decisions in the
  owning provider or domain code.
- Validate external input at the boundary and serialize explicit output. Do not leak secrets, internal
  errors, or persistence-only fields.
- Preserve the project's ORM and persistence boundary. Define transactions around business invariants.
- Use established guards, pipes, interceptors, filters, and middleware for their intended lifecycle
  responsibilities instead of duplicating them in feature handlers.
- Avoid request-scoped providers and `forwardRef()` by default; use them only when their lifecycle or
  dependency tradeoff is understood and justified.
- Give external I/O a timeout. Retry only bounded, repeat-safe work. Design queue consumers for duplicate
  delivery.
- Never edit generated API, ORM client, or applied migration files.
- Test changed behavior and provider wiring with the repository's existing tools.

## Check

Run relevant tests, strict type checks, linting, build, and contract or migration generation. Bootstrap
the affected Nest application or testing module when static checks cannot verify dependency wiring,
global enhancers, lifecycle hooks, or transport behavior.
