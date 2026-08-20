---
name: nextjs-engineering
description: Plan, implement, migrate, debug, or review Next.js applications across App Router and Pages Router, including RSC, SSR, SSG, ISR/revalidation, Cache Components/PPR, data fetching, Server Actions, Route Handlers, runtimes, routing, metadata, and deployment behavior. Use for Next.js architecture or code changes; do not activate for framework-agnostic React work.
---

# Next.js Engineering

Make the rendering, caching, and runtime behavior intentional and observable. Prefer the App Router for
new work, but preserve the router and conventions already used by the project unless migration is in scope.

## Establish the project model first

Before changing code, inspect `package.json`, the installed Next.js version, `next.config.*`, `app/` and
`pages/`, deployment configuration, and nearby route conventions. Do not infer semantics from the latest
documentation when the repository runs an older major version.

Classify the relevant route along these independent axes:

1. Router: App Router or Pages Router.
2. render location: server or browser.
3. render timing: build/revalidation time or request time.
4. cache policy: uncached, time-based, or on-demand invalidation.
5. runtime/deployment: Node.js, Edge where supported, static export, or self-hosted server.

Do not use “SSR” as a synonym for every Server Component. RSC describes where a component executes and
what crosses the client boundary; SSR/SSG/ISR describe when HTML and the RSC payload are produced.

## Route to the relevant guidance

- For SSR, SSG, ISR, PPR, `use cache`, cache tags, and invalidation, read
  [rendering-and-caching.md](references/rendering-and-caching.md).
- For RSC boundaries, data access, streaming, Server Actions, and Route Handlers, read
  [server-and-client.md](references/server-and-client.md).
- For layouts, route files, dynamic segments, metadata, runtimes, static export, or self-hosting, read
  [routing-and-runtime.md](references/routing-and-runtime.md).
- When `pages/`, `getServerSideProps`, `getStaticProps`, or `getStaticPaths` is involved, read
  [pages-router.md](references/pages-router.md).

Read only the references needed for the current task. When a change crosses several areas, read each
applicable reference before editing.

## Non-negotiable rules

- Server Components are the default in `app/`. Add `'use client'` only at the smallest interactive or
  browser-dependent boundary; it pulls that module's imports into the client graph.
- Keep secrets, privileged data access, and server-only dependencies behind a server boundary. Mark shared
  server modules with `import 'server-only'` when accidental client imports are plausible.
- Prefer direct database/service calls from Server Components. Do not call the application's own Route
  Handler from a Server Component; that adds an avoidable HTTP hop and can fail during prerendering.
- Use Server Actions primarily for user-triggered mutations, not general reads. Authenticate and authorize
  inside every action/handler; a server boundary is not an authorization boundary.
- Start independent I/O together and stream slow independent regions with `loading.tsx` or `<Suspense>`.
  Avoid sequential waterfalls created only by component nesting.
- Treat caching as a data-correctness decision. Never cache personalized or authorization-dependent output
  in a shared cache unless the chosen API explicitly provides the required isolation.
- After mutations, invalidate the smallest stable data identity. Prefer tags for shared entities/queries;
  use path invalidation when the path itself is the true dependency.
- Do not mix App Router and Pages Router APIs within one route model. Migration may be incremental by route,
  but each route must use the APIs of its own router.
- Preserve accessibility and use Next.js primitives (`Link`, `Image`, `next/font`, metadata APIs) when their
  behavior is useful; do not replace working project abstractions merely to use a framework primitive.

## Version-sensitive work

Next.js caching and request APIs change across majors. For version-sensitive changes, check the installed
types and the official documentation for that exact major before editing. In particular, verify:

- whether `cacheComponents` is enabled;
- whether the project uses the previous App Router cache model or Cache Components;
- async `params`, `searchParams`, `cookies()`, and `headers()` semantics;
- `middleware.ts` versus `proxy.ts` and runtime support;
- availability and exact behavior of `use cache`, `cacheLife`, `cacheTag`, `updateTag`, and
  `revalidateTag`.

Do not introduce experimental or canary APIs unless the user requests them or the repository already opts
in. Prefer codemods for major-version mechanical migrations, then inspect the diff and fix semantic changes.

## Verification

Use the repository's package manager and existing scripts. At minimum, run the narrow relevant tests and
type/lint checks; run `next build` when rendering classification, route discovery, static generation,
runtime boundaries, or deployment output changed. Inspect the build route table when available—runtime
success in dev does not prove SSG/ISR behavior.

For cache or rendering changes, verify both fresh and repeated requests and, when applicable, behavior after
the revalidation window or an on-demand invalidation. For RSC changes, also check browser console/hydration
errors and that secrets/server-only modules are absent from the client bundle.

Primary references: [App Router](https://nextjs.org/docs/app),
[Pages Router](https://nextjs.org/docs/pages), and
[Next.js upgrade guides](https://nextjs.org/docs/app/guides/upgrading).
