# API and Message Contracts

## Boundary Rules

- Treat every external request, event, webhook, file, environment value, and database result as untrusted
  until it is decoded and validated at the owning boundary.
- Use the repository's existing contract source: OpenAPI, GraphQL schema, protobuf, message schema,
  typed DTOs, or an equivalent established mechanism.
- Change the source contract and regenerate artifacts. Never edit generated clients, types, or schemas.
- Keep transport models separate from persistence models when exposing the latter would leak internal or
  sensitive fields.
- Apply authentication before authorization; evaluate authorization against the target resource and
  action, not only the route name.

## Evolution

- Prefer additive changes. Preserve existing fields and semantics during rollout.
- For breaking changes, define consumers, versioning or compatibility window, rollout order, migration,
  and removal criteria.
- Keep producer and consumer expectations compatible during mixed-version deployments.
- Make event schemas tolerant of additive fields and consumers explicit about unknown versions.

## Failure Semantics

- Use the transport's established error model and stable machine-readable codes where clients need to
  branch on failures.
- Do not expose stack traces, secrets, provider payloads, or database details.
- Distinguish invalid input, failed authentication, denied authorization, missing state, conflicts,
  rate limits, dependency failure, and internal failure when the transport supports it.

## Collections and Work

- Bound collection reads and batch sizes. Choose pagination based on ordering and consistency needs.
- Make mutation idempotency explicit when clients, queues, or gateways can repeat delivery.
- Document ordering, delivery, acknowledgement, retry, and deduplication semantics for messages.

## Check

Validate the contract with its existing tooling and test at least one real producer-consumer or
request-response boundary. Confirm generated artifacts and documented examples match runtime behavior.
