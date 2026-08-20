# Storage, Realtime, and Edge Functions

## Storage

- Treat bucket visibility and `storage.objects` policies as separate decisions. Public buckets make object
  delivery public; private buckets require authenticated or signed access.
- Scope object policies by bucket, object path, ownership, and tenant rules. Do not trust a filename or
  folder supplied by the client as proof of ownership.
- Account for every operation used by the client. Upload replacement or upsert may require select, insert,
  and update access rather than insert alone.
- Bound file size and type, avoid unsafe overwrite defaults, set appropriate cache behavior, and clean up
  partial or orphaned objects when multi-step workflows fail.

## Realtime

- Subscribe only to the tables, events, filters, and channels required by the product flow.
- Preserve RLS and tenant isolation for database-change delivery; test with a non-owner account.
- Reconcile events into the application's existing server-state owner rather than creating a parallel copy.
- Handle connection state, duplicate or missed events, resubscription, and component or process cleanup.

## Edge Functions

- Verify the current Edge Functions runtime, supported APIs, dependency conventions, and configuration
  against official docs before coding.
- Keep secrets in the platform's secret store and access them only inside trusted functions.
- Make authentication and authorization explicit. A function endpoint is not protected merely because it
  lives in a Supabase project.
- Validate request bodies, webhooks, and provider signatures before effects. Use raw bytes when signature
  verification requires them.
- Bound external calls with timeouts; retry only idempotent or deduplicated work.
- Apply CORS only for intended browser callers and handle preflight consistently with the repository.

## Check

Exercise real upload or signed access and cleanup, Realtime delivery and unsubscribe, or function invoke
and logs as applicable. Test denied tenant access and avoid using service-role clients as proof.
