# Reliability and Operations

## External Work

- Give every network call and blocking operation a timeout appropriate to the caller's budget.
- Retry only transient failures, with bounded attempts and backoff. Ensure the operation is idempotent or
  protected against duplicate effects before retrying.
- Bound concurrency, queue depth, payload size, result size, and memory use.
- Make cancellation and shutdown behavior explicit for long-running work.

## Background Jobs and Events

- Acknowledge work only after its durable effects meet the required guarantee.
- Design consumers for duplicate delivery unless the infrastructure proves exactly-once behavior end to
  end.
- Separate transient, permanent, and poison-message failures; expose exhausted work for diagnosis or
  recovery.
- Use an outbox, inbox, or equivalent coordination pattern when database state and message publication
  must behave as one business operation.

## Observability

- Log stable event names and useful identifiers, not secrets or entire payloads.
- Propagate the existing correlation or trace context across requests, jobs, and integrations.
- Add metrics for throughput, latency, errors, saturation, queue age, and retries where the changed path
  needs operator visibility.
- Preserve error causes and useful context without converting expected domain outcomes into alerts.

## Runtime and Deployment

- Validate required configuration at startup and fail clearly before accepting work.
- Distinguish liveness from readiness; readiness may reflect whether the instance can safely serve work.
- Drain traffic and stop accepting new work before closing connections or terminating consumers.
- Keep startup, shutdown, and migration order compatible with rolling deployments.

## Check

Exercise dependency failure, timeout, retry exhaustion, duplicate delivery, and shutdown when affected.
Confirm dashboards, logs, traces, or local equivalents make the result diagnosable without sensitive data.
