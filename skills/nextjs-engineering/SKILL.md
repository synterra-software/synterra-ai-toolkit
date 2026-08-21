---
name: nextjs-engineering
description: Always use for any Next.js work — App Router or Pages Router, RSC, SSR, SSG, ISR, Cache Components/PPR, routing, Server Actions, Route Handlers, metadata, runtimes, deployment, migration, and debugging. Load it together with `software-engineering`, `frontend-engineering`, and `react-engineering`.
---

# Next.js Engineering

Apply `software-engineering`, `frontend-engineering`, and `react-engineering` first, then this skill for
every Next.js change; it adds Next.js-specific rendering, caching, routing, and runtime decisions without
replacing their guidance. Preserve the installed Next.js version, router, rendering/cache model, deployment
target, and repository conventions. Prefer the App Router for new applications, but do not migrate an existing
route unless that migration is in scope.

## Establish the project model first

Before changing code, inspect `package.json`, `next.config.*`, `app/`, `pages/`, deployment configuration,
and nearby route conventions. Use installed types and documentation for the repository's exact major.

Classify the relevant route along these independent axes:

1. Router: App Router or Pages Router.
2. render location: server or browser.
3. render timing: build/revalidation time or request time.
4. cache policy: uncached, time-based, or on-demand invalidation.
5. runtime/deployment: Node.js, Edge where supported, static export, or self-hosted server.

RSC describes where a component executes and what crosses the client boundary. SSR, SSG, and ISR describe
when route output is produced. Do not use these terms interchangeably.

## Route to the relevant guidance

- For SSR, SSG, ISR, PPR, `use cache`, cache tags, and invalidation, read
  [rendering-and-caching.md](references/rendering-and-caching.md).
- For RSC boundaries, data access, streaming, Server Actions, and Route Handlers, read
  [server-and-client.md](references/server-and-client.md).
- For layouts, route files, dynamic segments, metadata, runtimes, static export, or self-hosting, read
  [routing-and-runtime.md](references/routing-and-runtime.md).
- When `pages/`, `getServerSideProps`, `getStaticProps`, or `getStaticPaths` is involved, read
  [pages-router.md](references/pages-router.md).

Read every matching reference and no unrelated reference.

## Cross-cutting invariants

- Keep secrets and privileged data access behind a server boundary.
- Treat shared caching of personalized or authorization-dependent output as a correctness and security bug.
- Keep each route within one router's APIs; incremental migration may happen route by route.
- Use Next.js primitives when their behavior is required, but preserve compatible project abstractions.
- Do not introduce experimental or canary APIs unless requested or already enabled by the repository.

## Version-sensitive work

Next.js caching and request APIs change across majors. Verify:

- whether `cacheComponents` is enabled;
- whether the project uses the previous App Router cache model or Cache Components;
- async `params`, `searchParams`, `cookies()`, and `headers()` semantics;
- `middleware.ts` versus `proxy.ts` and runtime support;
- availability and exact behavior of `use cache`, `cacheLife`, `cacheTag`, `updateTag`, and
  `revalidateTag`.

Prefer official codemods for major-version mechanical migrations, then inspect the diff and resolve semantic
changes deliberately.

## Verification

Run relevant tests, types, and lint. Run a production `next build` when routing, rendering classification,
static generation, runtime boundaries, or deployment output changes; development success does not prove
SSG/ISR behavior. Apply the scenario-specific checks from the selected references.

Primary references: [App Router](https://nextjs.org/docs/app),
[Pages Router](https://nextjs.org/docs/pages), and
[Next.js upgrade guides](https://nextjs.org/docs/app/guides/upgrading).
