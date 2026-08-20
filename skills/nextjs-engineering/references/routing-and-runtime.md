# Routing, runtime, and delivery

## App Router conventions

Use `app/` special files for their framework lifecycle rather than recreating it in client state:

- `layout.tsx` for persistent shared UI; root layout owns `<html>` and `<body>`;
- `template.tsx` only when remount-on-navigation semantics are required;
- `loading.tsx` for route-segment Suspense fallback;
- `error.tsx` for a client error boundary and `global-error.tsx` for root failures;
- `not-found.tsx` with `notFound()` for missing resources;
- `route.ts` for HTTP handlers;
- `default.tsx` for unmatched parallel-route slots;
- metadata exports/files for SEO, manifests, icons, and social images.

Use route groups `(group)` to organize without changing the URL, dynamic segments `[id]`, catch-all segments
`[...slug]`, optional catch-all `[[...slug]]`, parallel slots `@slot`, and intercepting routes only when the
navigation and direct-load behavior both need them. Modal interception must have a valid full-page route and
a fallback/default for hard reloads.

Use `generateStaticParams` for dynamic paths worth prerendering. Decide explicitly whether unspecified paths
are generated on demand or rejected, using APIs supported by the installed version/cache model.

Generate metadata on the server. Avoid duplicate network/database reads between metadata and page rendering;
share a cached/memoized data function when its cache semantics are correct. Use `next/image`, `next/font`,
`next/script`, and `Link` with correct `sizes`, loading strategy, and navigation semantics—not mechanically.

## Runtime choice

Default to Node.js. It has the broadest package, filesystem, crypto, database-driver, caching, and framework
feature compatibility. Select Edge only for a measured latency/deployment need and after verifying every
dependency and Next.js feature used by the route supports it.

Runtime is independent from rendering timing: Node.js routes can be prerendered or request-rendered, and an
Edge label does not itself mean content is cached globally.

Next.js 16 renamed `middleware.ts` to `proxy.ts`; Proxy uses Node.js in that major. Preserve the convention
supported by the installed version and migrate with the official codemod when upgrading.

## Delivery modes

### Managed or server deployment

Confirm how the host persists ISR/data caches, supports streaming, maps Route Handlers to functions, applies
timeouts/body limits, and handles image optimization. Platform defaults are part of application behavior.

### Self-hosted

Use the project's supported production server, commonly `next start` or `output: 'standalone'` in a container.
With multiple instances, coordinate cache storage and tag/path invalidation. Put a reverse proxy in front only
with cache headers that do not conflict with Next.js revalidation. Provide persistent storage/services for
uploads, jobs, sessions, and WebSockets instead of relying on function-local state.

### Static export

`output: 'export'` produces files for a static host and has no request-time Next.js server. Reject or redesign
features requiring runtime SSR, Server Actions, request-dependent cookies/headers, runtime revalidation, most
dynamic Route Handlers, or built-in dynamic image optimization. Ensure every dynamic route is enumerable and
all runtime-dependent behavior is replaced by browser APIs/external services where appropriate.

## Verification

- Run `next build` and inspect which routes are static, dynamic, or generated.
- Test direct URL loads as well as client navigation, especially for parallel/intercepted routes.
- Test `not-found`, thrown-error, loading/streaming, redirect, and unauthorized states.
- Check HTML/metadata without JavaScript and hydration/console behavior with JavaScript.
- Test production mode; development rendering and caching behavior intentionally differ.
- For self-hosting, test more than one process/container when shared cache correctness matters.

Official references:
[Project structure](https://nextjs.org/docs/app/getting-started/project-structure),
[Metadata](https://nextjs.org/docs/app/getting-started/metadata-and-og-images),
[Static exports](https://nextjs.org/docs/app/guides/static-exports), and
[Self-hosting](https://nextjs.org/docs/app/guides/self-hosting).
