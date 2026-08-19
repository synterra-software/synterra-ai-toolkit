# Async Work and Lifecycle

## External Calls

- Use the project's existing HTTP or SDK wrapper so authentication, telemetry, and error mapping remain
  consistent.
- Apply an explicit timeout and propagate cancellation when the installed client supports it.
- Retry only classified transient failures with bounded attempts and backoff. Confirm idempotency before
  retrying mutations.
- Map provider-specific failures at the integration boundary; do not leak them through product services.

## Queues, Events, and Schedules

- Keep consumers thin: decode, validate, establish context, invoke the owning provider, then acknowledge
  according to the queue's delivery contract.
- Assume duplicate delivery unless the complete system proves otherwise. Use stable operation keys or
  durable deduplication for effectful work.
- Distinguish retryable, permanent, and poison-message failures. Preserve enough context to recover
  exhausted work without logging sensitive payloads.
- Bound concurrency and work size. Ensure scheduled work cannot overlap when overlap would violate an
  invariant.

## Nest Lifecycle

- Use `OnModuleInit` and `OnApplicationBootstrap` for initialization that belongs to the provider or
  application lifecycle, not for hidden business work.
- Enable shutdown hooks when the deployment relies on termination signals, then stop accepting new work,
  drain consumers, and close external resources in the appropriate destroy or shutdown hook.
- Remember that request-scoped providers do not receive normal application shutdown lifecycle hooks.
- Clean up timers, subscriptions, listeners, and long-lived connections owned by a provider.

## Request Context

Use the repository's existing correlation context. Prefer explicit parameters for ordinary domain data.
Use `AsyncLocalStorage` or an established CLS wrapper only for true request or operation context, keep the
store typed and small, and avoid turning it into an implicit dependency container.

## Check

Test timeouts, retry exhaustion, duplicates, acknowledgement, overlapping schedules, and shutdown when
affected. Bootstrap and close the application in integration tests when lifecycle behavior matters.
