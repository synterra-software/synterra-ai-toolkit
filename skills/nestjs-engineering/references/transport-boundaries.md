# Transport Boundaries

## Request and Message Flow

- Middleware handles raw transport concerns that must run before Nest's execution context.
- Guards decide whether the caller may reach a handler.
- Pipes decode and validate handler inputs.
- Controllers, resolvers, and message handlers translate protocol data and delegate product behavior.
- Interceptors wrap execution for established cross-cutting behavior such as tracing or response mapping.
- Exception filters translate known failures into the transport's error contract.

Use the repository's current enhancer placement and ordering. Do not register the same concern globally
and locally without an explicit reason.

## Inputs

- Represent structured external input with typed DTOs or the project's established schema mechanism.
- Enable transformation only when its coercion semantics are intended and tested.
- Validate body, params, query, headers, webhook payloads, and message data that influence behavior.
- Never use a TypeScript assertion as runtime validation.

## Outputs and Errors

- Return explicit response or message models when persistence objects contain private or internal fields.
- Preserve the established error envelope and machine-readable codes.
- Map expected domain outcomes deliberately. Unexpected errors retain diagnostic causes internally but do
  not expose stack traces, database errors, or provider payloads.
- Keep status codes, GraphQL errors, RPC exceptions, and acknowledgement behavior consistent with the
  active transport.

## Contracts

- If the service owns OpenAPI, GraphQL, protobuf, or message schemas, update the source contract and
  regenerate consumers or artifacts through existing commands.
- Keep decorators and runtime responses aligned. Do not add Swagger-specific dependencies to a project
  that uses a different contract source.
- Preserve compatibility during rolling deployments and coordinate breaking changes with consumers.

## Check

Test boundary decoding, denied access, validation failures, success output, and translated errors through
the real Nest transport where enhancer order matters. Validate or regenerate the contract when affected.
