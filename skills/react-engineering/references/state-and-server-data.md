# State and Server Data

## One Authoritative Owner

Assign each value to exactly one owner:

- Derive values during rendering when they can be computed from existing state.
- Use local React state or a reducer for small component-only interaction state.
- Use React Hook Form for unsaved form values, validation, and form lifecycle.
- Use context for stable cross-tree dependencies or infrequently changing application values such as theme or session access. Do not copy backend entities into context.
- Use the repository's existing client store for frequently changing shared client-only interaction state such as selection, drag state, unsaved workspace state, or undo history.
- Use the repository's server-state client and cache for backend-owned data, regardless of how frequently the user edits it.

Do not mirror backend-owned entities into local state, context, or a separate client store. A form draft, request payload, optimistic layer, rollback snapshot, and server response are lifecycle representations, not additional authoritative stores.

If offline-first synchronization or a complex editor requires a separate working model, define its ownership and synchronization contract explicitly.

## Immutable Updates and Immer

- Use the simplest immutable update that remains clear. Prefer native object spread, `map`, and `filter` for small updates.
- Use Immer when it is already installed and the update changes complex nested client state.
- If Immer is absent and nested immutable updates are becoming verbose or error-prone, recommend it with the dependency tradeoff before adding it.
- When a Zustand store already uses Immer middleware, perform nested updates through that middleware instead of manually cloning the structure.
- Update only the intended path and preserve unchanged references. Do not copy or replace unrelated branches.
- Use the server-state library's native cache-update API for backend data rather than applying Immer as a parallel state layer.
- Do not treat Immer as a render-optimization tool. Granular component updates come from focused store selectors, state boundaries, and stable equality behavior.

## Server-State Library

- Use the server-state solution already established by the repository, such as Apollo Client, TanStack Query, RTK Query, SWR, or the framework's equivalent.
- Do not replace the established solution merely to follow an example from another stack.
- Consult current official documentation for the installed library version before implementing cache or synchronization behavior.
- Use the library's native cache, optimistic-update, reconciliation, rollback, invalidation, refetch, and subscription mechanisms.
- Respect its normalized-cache, query-key, pagination, ordering, and filtering semantics.

## Optimistic and Real-Time Updates

- For an optimistic mutation, update the designated server-state cache immediately.
- Reconcile the optimistic value with the authoritative response and roll it back on failure.
- Refresh only affected data when server ordering, filtering, permissions, or computed values require it.
- Keep cache behavior in the application data or domain layer so every relevant consumer sees a consistent result.
- Update the same cache from real-time events. Do not introduce a parallel store for subscription data.

## Verification

- Confirm every changed state value has one authoritative owner.
- Confirm immutable updates preserve unrelated references and components subscribe only to the state they use.
- Exercise optimistic success, server reconciliation, rollback, concurrent mutations, and targeted refresh behavior that apply to the flow.
- Confirm filters, ordering, pagination, and real-time events cannot leave cache consumers inconsistent.
