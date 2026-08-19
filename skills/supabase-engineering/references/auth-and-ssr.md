# Auth and SSR

## Client Boundaries

- Use the framework's current official Supabase integration and preserve its browser/server client split.
- Browser clients use the public publishable key. Server clients may use the caller's session to preserve
  RLS. Privileged admin clients are separate, server-only, and narrowly scoped.
- Do not create a new client pattern when the repository already centralizes cookie, token, and error
  handling.

## Identity and Sessions

- Use the current official method intended to verify token claims when protecting pages or data.
- Use a server-confirmed user lookup when the latest Auth record is required and the network cost is
  justified.
- Use session access when the raw access or refresh token is actually needed; do not trust a user object
  loaded only from caller-controlled or shared storage for authorization.
- Authorization still belongs in RLS, server policy, or both. Authentication alone does not prove access
  to a tenant or resource.

## SSR Cookies and Caching

- Follow the installed SSR package and framework adapter for cookie reads, writes, refresh, and PKCE.
- Apply refreshed cookies and required cache headers to the actual response. Auth responses must not be
  shared through a CDN or framework cache across users.
- Preserve secure cookie attributes appropriate to the environment and callback flow.
- Handle token refresh and sign-out without leaving stale server or browser state.

## Authorization Data

- Keep roles and permissions out of user-editable metadata.
- When authorization claims change, define how and when active sessions receive fresh claims.
- Revoking or deleting a user does not necessarily invalidate every already-issued token immediately;
  design stricter checks for sensitive operations when required.

## Check

Test sign-in, callback, refresh, protected access, sign-out, expired or revoked credentials, and
cross-user caching behavior that apply. Verify the browser bundle contains no privileged key.
