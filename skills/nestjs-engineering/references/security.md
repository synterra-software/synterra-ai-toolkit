# Security

## Authentication and Authorization

- Reuse the service's established authentication strategy and guard composition.
- Mark public handlers through the existing explicit mechanism; do not infer public access from a missing
  guard when protection is global or inherited.
- Keep authentication separate from authorization. Evaluate roles, permissions, ownership, tenant, and
  resource state required by the action.
- Do not trust caller-controlled tenant, user, role, or permission identifiers without binding them to the
  authenticated principal.

## Inputs and Outputs

- Apply strict boundary validation and reject unexpected fields when the service's compatibility contract
  permits it.
- Prevent mass assignment by mapping accepted DTO fields explicitly into writes.
- Serialize responses so credentials, tokens, password hashes, internal flags, and unrelated tenant data
  cannot escape.
- Verify webhook signatures over the exact raw bytes and enforce the provider's timestamp or replay rules
  before processing.

## Configuration and Logs

- Read secrets through the established configuration provider, validate required values at startup, and
  never embed them in defaults.
- Redact authorization headers, cookies, tokens, credentials, sensitive identifiers, and payload fields
  from logs and exception context.
- Keep cryptography in maintained libraries and existing security adapters; do not invent token formats,
  password hashing, signature schemes, or key rotation.

## Abuse and Isolation

Assess rate limits, payload limits, query complexity, file limits, and expensive operations at the
appropriate application or gateway boundary. Enforce tenant filters and ownership checks in every data
path, including jobs and administrative endpoints.

## Check

Test anonymous, authenticated-but-forbidden, cross-tenant, malformed, replayed, and sensitive-output
cases that apply. Run the repository's security checks when present.
