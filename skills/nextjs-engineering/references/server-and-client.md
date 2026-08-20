# Server/client boundaries and data flow

## RSC boundary

In the App Router, pages and layouts are Server Components unless a client boundary is declared.

Use a Server Component for data access, secrets, server-only packages, heavy non-interactive work, metadata,
and reducing browser JavaScript. Use a Client Component only for state, event handlers, effects, custom hooks
that require them, context providers, or browser APIs.

Place `'use client'` at a leaf-like entry point. Everything imported beneath that entry joins the client
module graph. Prefer passing rendered Server Component content through `children`/slots over importing server
modules into a client graph. Props crossing from server to client must be React-serializable.

Do not make a Client Component `async`. Fetch on the server and pass serializable data, stream a promise with
React's supported APIs when appropriate, or use a client data library for client-owned data.

Use `server-only` for modules with secrets, privileged data access, filesystem/native server dependencies,
or other code that must fail fast if imported by a Client Component.

## Data fetching

- Fetch directly in Server Components or server-only data modules. ORM/database calls are valid there.
- Let framework/request memoization or React `cache` deduplicate identical work only when supported; do not
  assume arbitrary database calls are deduplicated.
- Start independent promises before awaiting them. Use `Promise.all` when they must complete together.
- Use `loading.tsx` for a route-segment loading state and `<Suspense>` for finer streaming boundaries.
- Put Suspense boundaries around meaningful UI regions; avoid many tiny boundaries that cause layout churn.
- Do not fetch through your own Route Handler from server-rendered code. Call the underlying service module.
- Use client fetching for browser-only sources, polling/realtime UX, or data whose ownership truly belongs to
  an interactive client island.

Request-time APIs such as `cookies()`, `headers()`, `searchParams`, and `params` are version-sensitive and are
asynchronous in current App Router versions. Their use can affect prerendering. Verify installed types rather
than forcing casts or copying an older synchronous pattern.

## Server Actions / Server Functions

Use `'use server'` actions for mutations initiated by the UI. Keep the public action thin:

1. authenticate the caller;
2. authorize access to the target resource;
3. validate and normalize untrusted input;
4. call a server-only domain/service function;
5. invalidate affected cache identities;
6. return a small serializable result or redirect.

Treat exported actions as remotely callable endpoints. Do not trust hidden fields, client-supplied user IDs,
or TypeScript types. Avoid using actions for reads because action dispatch is mutation-oriented and can be
queued. Handle expected validation failures as data; reserve thrown errors for exceptional failures.

## Route Handlers

Use `app/**/route.ts` for HTTP APIs, webhooks, callbacks, feeds/files, or endpoints consumed outside the React
tree. A route segment cannot contain both `page.tsx` and `route.ts` at the same level.

- Authenticate/authorize handlers independently.
- Validate body, query, params, content type, and webhook signatures.
- Return deliberate status codes and headers.
- Keep domain logic in reusable server-only modules so actions, handlers, and RSC can call it directly.
- Do not assume memory, writable filesystem, long execution, or WebSockets survive across serverless requests.
- Make cache headers and handler caching intentional; do not assume a `GET` handler is cached in every major.

Use Proxy only for request interception that must happen before routing/cache lookup, such as narrowly scoped
redirects, rewrites, or coarse admission checks. Avoid database-heavy authorization there; perform definitive
authorization at the data/action/handler boundary.

Official references:
[Server and Client Components](https://nextjs.org/docs/app/getting-started/server-and-client-components),
[Fetching data](https://nextjs.org/docs/app/getting-started/fetching-data),
[Updating data](https://nextjs.org/docs/app/getting-started/updating-data), and
[Route Handlers](https://nextjs.org/docs/app/getting-started/route-handlers).
