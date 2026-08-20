# Testing

## Choose the Smallest Test That Proves the Behavior

- Test pure domain rules and ordinary provider behavior directly with typed fakes or mocks.
- Use `Test.createTestingModule()` when provider tokens, module imports, scopes, decorators, guards,
  pipes, interceptors, filters, or lifecycle wiring are part of the behavior.
- Use integration tests with the real database, broker, cache, or provider emulator when mocks would hide
  query, transaction, serialization, delivery, or protocol behavior.
- Use end-to-end tests through the bootstrapped Nest application for transport contracts and global
  enhancer order.

## Test Boundaries

- Assert observable outcomes and durable state, not private method calls.
- Cover validation, authorization, expected domain failures, translated dependency failures, and cleanup
  relevant to the change.
- Reset mocks and isolate test data. Do not share mutable application state across tests.
- Override providers with the same token the consuming module injects; keep fakes behaviorally accurate
  for the scenario under test.
- Close applications, testing modules, database clients, workers, timers, and open handles.

## Contracts and Generated Artifacts

Validate OpenAPI, GraphQL, message, or generated ORM artifacts with the repository's commands. Add a real
producer-consumer or request-response check when changing a shared contract.

## Check

Run the narrow affected tests first, then strict types, lint, build, and the broader integration or E2E
suite required by the changed boundary. Confirm the test actually fails when the intended behavior is
removed or broken.
