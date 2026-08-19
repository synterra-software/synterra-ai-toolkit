# Row Level Security and Security

## Data API Exposure

- Data API grants determine whether a role can access a table; RLS determines which rows are visible or
  writable after access is granted. Verify both layers.
- Enable RLS on every table in an exposed schema and grant only required operations to `anon` and
  `authenticated`.
- A policy targeted to `authenticated` is not authorization by itself. Add ownership, membership, tenant,
  or permission predicates that match the product rule.
- For updates, define both which existing rows may be selected or updated and which resulting values are
  allowed. Remember that updates also require the necessary select policy.

## Claims and Policies

- Treat user-editable metadata as untrusted. Keep authorization claims in server-controlled app metadata
  or authoritative tables.
- Account for claim freshness when authorization depends on JWT content; a policy may see claims from the
  current token until it is refreshed.
- Index columns used by policy predicates and test policy behavior at realistic scale.
- Avoid policy recursion and hidden cross-table access; use narrowly scoped database functions only when
  the access model genuinely requires them.

## Views and Functions

- Verify whether each exposed view invokes the caller's permissions and RLS. Use the Postgres-version
  appropriate `security_invoker` behavior or keep the view out of exposed schemas.
- Prefer invoker rights. A `SECURITY DEFINER` function bypasses the caller's RLS and can become a public
  privilege boundary; place justified functions in a non-exposed schema, set a safe search path, revoke
  default execution, grant explicit callers, and validate identity inside the function.
- Do not add definer rights merely to make a permission error disappear.

## Keys and Privileged Clients

- Publishable keys identify public clients and still require correct grants and RLS.
- Secret and service-role keys bypass RLS. Keep them in trusted server environments and separate clients
  from user-session flows so an auth operation cannot replace or confuse privileged credentials.
- Never use a privileged client to test user access.

## Verification Matrix

For every affected policy, test the roles and states that matter: anonymous, authenticated owner,
authenticated non-owner or cross-tenant user, privileged server path, missing claims, and forbidden new
values. Assert returned or changed rows, not only the absence of an exception.
