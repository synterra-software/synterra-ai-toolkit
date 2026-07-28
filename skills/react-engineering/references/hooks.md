# React Hooks

## General Rules

- Follow the Rules of Hooks and the repository's React Hooks lint configuration.
- Keep components and Hooks pure. Move interaction-specific work into the event or form handler that caused it.
- Derive values during rendering instead of synchronizing derived state through an Effect.
- Consult current official React documentation for the repository's React version before using version-specific Hook behavior.

## `useEffect`

Treat an Effect as an escape hatch for synchronizing React with an external system. Before adding one, confirm the work cannot be expressed during rendering, in an event handler, through a key-based reset, or through an established framework or library abstraction.

Appropriate uses include subscriptions, timers, browser APIs, imperative widgets, and other non-React systems that must remain synchronized with rendered state.

- Never issue application queries or mutations directly from an Effect.
- For route or server data, use the repository's existing server-state library, GraphQL client, router loader, server component, or framework data API.
- For interaction-driven mutations, call the application data hook or function from the event or React Hook Form submission handler.
- If the repository has no suitable data solution, recommend a compatible library or framework mechanism with its tradeoffs before adding it.
- Do not use an Effect to transform props or state, copy state, handle user events, notify parents, or chain state transitions.
- Declare every reactive dependency. Do not suppress the Hooks linter or omit dependencies to control execution.
- Make setup and cleanup symmetrical, and ensure the Effect remains correct when React starts, cleans up, and starts it again.

## `useMemo`

Use `useMemo` only for a pure calculation when at least one concrete benefit exists:

- Measurement shows that recalculation is meaningfully expensive.
- Stable object or array identity lets a memoized consumer skip meaningful work.
- Stable identity is required by another Hook or integration contract.

Do not use `useMemo` for correctness, side effects, cheap calculations, primitive values, or routine object creation without a demonstrated consumer. If an unstable dependency defeats memoization, simplify or move that dependency before adding more memoization.

## `useCallback`

Use `useCallback` only when stable function identity has a concrete consumer:

- The function is passed to a memoized child and its changing identity would otherwise prevent a useful render skip.
- The function is a dependency of another Hook and stabilizing it is clearer than restructuring that Hook.
- A custom Hook returns the function as part of a stable consumer-facing API.
- An external integration explicitly requires stable callback identity.

Passing a function as a prop does not by itself justify `useCallback`. A non-memoized child still renders with its parent, and ordinary event handlers do not benefit from memoization merely because they are functions.

## React Compiler

Inspect whether React Compiler is enabled and supported by the repository. When it performs the required memoization, do not add redundant manual `useMemo`, `useCallback`, or `memo`. Preserve manual memoization only when it defines an intentional identity contract or has a verified performance benefit.

## Verification

- Confirm every Effect synchronizes with an actual external system and has complete dependencies and cleanup where required.
- Confirm no application query or mutation originates from an Effect.
- Confirm each `useMemo` and `useCallback` has an identifiable consumer or measured benefit.
- Remove memoization and Effects that do not satisfy these rules.
- Run the Hooks linter and relevant behavior and performance checks.
