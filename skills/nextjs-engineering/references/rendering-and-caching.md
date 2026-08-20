# Rendering and caching

Use this reference to choose and verify SSR, SSG, ISR/revalidation, Cache Components, and PPR behavior.

## Keep the concepts separate

| Term | Operational meaning |
|---|---|
| RSC | React renders Server Components on the server and sends an RSC payload; this alone does not say when the route is rendered. |
| SSR / dynamic rendering | The route output is produced at request time. Use for request-specific, personalized, or always-fresh output. |
| SSG / prerendering | The route output is produced ahead of requests and reused. Use for shared content that can be known without request-time state. |
| ISR / revalidation | Cached/prerendered output is regenerated after time or invalidation without rebuilding the entire application. |
| CSR | A Client Component obtains/renders data in the browser. Reserve for browser-only or highly interactive/polled data. |
| Streaming | The server sends ready route regions before slower regions. It can be combined with request-time or prerendered output. |
| PPR / Cache Components | A static shell and cached regions are combined with dynamic regions that stream through Suspense boundaries. |

`ISR` is the correct acronym; “IRS” is a typo.

## Choose from data requirements

- Shared and effectively immutable until deployment: prerender/SSG.
- Shared and allowed to be stale for a known interval: time-based ISR/revalidation.
- Shared and changed by a known event: long-lived cache plus tag-based on-demand invalidation.
- Personalized, authorization-dependent, or request-context-dependent: request-time rendering; cache only
  lower-level shared data whose key does not leak user context.
- Browser-only capability or very frequent polling: a small Client Component with a client data library.
- Mixed page: prerender/cache stable regions and isolate request-time regions behind Suspense when the
  project's Next.js version and cache model support it.

Do not select a strategy for SEO alone: both SSR and prerendering can return crawlable HTML. Prefer the
least dynamic strategy that satisfies freshness and personalization.

## App Router: identify the cache model

### Cache Components enabled

When `cacheComponents: true` is enabled, use the current Cache Components model:

- uncached async data and request-time APIs form dynamic regions and must be isolated appropriately with
  `<Suspense>`;
- add `'use cache'` to a function/component only when its inputs and output are safe to share;
- make lifetime explicit with `cacheLife(...)` when the default profile is not the product requirement;
- associate cached data with stable identities using `cacheTag(...)`;
- use `updateTag(tag)` in a Server Action for immediate expiry/read-your-own-writes;
- use `revalidateTag(tag, 'max')` for stale-while-revalidate when brief staleness is acceptable;
- use `revalidatePath(path)` when all cached dependencies for a route path must be refreshed;
- Cache Components require the Node.js runtime; do not add `runtime = 'edge'` to those routes.

`stale`, `revalidate`, and `expire` in a cache-life profile govern different phases. Do not copy durations
without relating them to the product's allowed staleness, refresh frequency, and blocking fallback.

### Previous App Router cache model

When Cache Components are not enabled, preserve the repository's supported APIs. Depending on the installed
major, these can include:

- `fetch(url, { cache: 'force-cache' })` for reusable data;
- `fetch(url, { cache: 'no-store' })` for request-time data;
- `fetch(url, { next: { revalidate: seconds, tags: [...] } })` for timed/tagged data;
- route segment exports such as `revalidate`, `dynamic`, and `fetchCache`;
- `unstable_cache` for non-`fetch` asynchronous data in versions where it is the supported API.

Do not mechanically combine old route segment controls with Cache Components. In Next.js 16 migration,
`use cache`/`cacheLife` replace several previous route-level caching controls.

## Invalidation design

Tag cached data by domain identity, not by component name:

- `post:${id}` for one entity;
- `posts` or `posts:${filterHash}` for a collection/query;
- both entity and collection tags when a mutation affects both.

After a mutation, invalidate only affected tags. Use `updateTag` when the same user must immediately observe
the write. Use stale-while-revalidate when lower latency and availability matter more than immediate global
freshness. Validate webhook authenticity before allowing it to trigger revalidation.

Remember that browser/router caches, the Next.js data/output cache, a reverse proxy/CDN, and the upstream API
may each cache independently. Purging one layer does not necessarily purge the others.

## Failure and deployment semantics

- A failed background regeneration should leave the last successful cached result available; verify the
  actual platform/self-hosting behavior.
- Multi-instance self-hosting needs a shared/durable cache and coordinated invalidation if instances must
  serve the same ISR result.
- Static export has no Next.js runtime and therefore cannot perform request-time SSR, Server Actions, or
  runtime ISR/revalidation.
- Edge runtime support differs by feature and version; verify before choosing it for ISR or Cache Components.

Official references:
[Cache Components](https://nextjs.org/docs/app/getting-started/cache-components),
[Revalidating](https://nextjs.org/docs/app/getting-started/revalidating),
[Caching guide (previous model)](https://nextjs.org/docs/app/guides/caching), and
[Migrating to Cache Components](https://nextjs.org/docs/app/guides/migrating-to-cache-components).
