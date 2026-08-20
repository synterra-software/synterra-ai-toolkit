# Pages Router

Use this reference only for routes under `pages/` or an explicit Pages-to-App migration.

## Rendering APIs

| Requirement | Pages Router API |
|---|---|
| Shared output generated at build time | `getStaticProps` |
| Dynamic static paths | `getStaticPaths` + `getStaticProps` |
| Static output refreshed over time | return `revalidate` from `getStaticProps` |
| On-demand page regeneration | authenticated server endpoint calling `res.revalidate(path)` |
| Per-request/personalized output | `getServerSideProps` |
| Browser-owned data | client fetching in the component |

Never export `getStaticProps` and `getServerSideProps` from the same page. These functions run only on the
server, but their returned props are serialized into the page response; do not return secrets or unnecessary
records.

## SSG and ISR

Use `getStaticPaths` for dynamic route seeds. Choose fallback behavior deliberately:

- `false`: only listed paths exist until the next build;
- `'blocking'`: an unlisted path is generated on first request, then cached;
- `true`: supports a fallback state before generation; use only when that UX is intended and compatible with
  the route's client behavior.

`revalidate` is measured in seconds and enables stale-while-regenerate behavior; it is not a precise cron.
The first eligible request triggers regeneration. Keep the last successful output when regeneration fails and
retry later. Secure on-demand revalidation endpoints and validate the exact path supplied by a CMS/webhook.

## SSR

Use `getServerSideProps` only when the response truly depends on request-time data or cannot tolerate shared
staleness. Authenticate and authorize there, avoid serial waterfalls, and return `notFound` or `redirect`
instead of encoding routing decisions in client effects. Set cache headers only when personalized data cannot
be shared accidentally.

## API routes and document/app files

- `pages/api/*` are HTTP endpoints, not functions to call from `getServerSideProps`/`getStaticProps`; share a
  server module instead.
- `_app` is for cross-page composition/providers; adding `getInitialProps` there disables automatic static
  optimization for pages that do not have their own static data method.
- `_document` customizes the outer document and runs only on the server; it is not for application data or
  event handlers.
- Prefer `next/head` only in Pages Router; App Router uses the Metadata API.

## Incremental migration

`app/` and `pages/` may coexist while routes move incrementally, but the same URL must have one owner. Do not
import App Router-only APIs into a Pages route or reproduce `getServerSideProps` inside an App page. When
migrating, re-evaluate caching and RSC boundaries rather than performing a line-for-line API translation.

Official references:
[Pages data fetching](https://nextjs.org/docs/pages/building-your-application/data-fetching),
[SSR](https://nextjs.org/docs/pages/building-your-application/data-fetching/get-server-side-props),
[SSG](https://nextjs.org/docs/pages/building-your-application/data-fetching/get-static-props), and
[ISR guide](https://nextjs.org/docs/pages/guides/incremental-static-regeneration).
