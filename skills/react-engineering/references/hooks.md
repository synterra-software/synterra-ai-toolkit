# Hooks

## Rules

- Follow Hooks lint rules; never suppress dependency warnings.
- Keep Hooks pure. Derive during rendering; run interaction logic in its handler.

## `useEffect`

- Use only for external synchronization: subscriptions, timers, browser APIs, or imperative widgets.
- Never issue application queries or mutations from an Effect.
- Use the existing data or framework layer; trigger interaction mutations from their handler.
- If no data layer exists, recommend one before adding it.
- Never derive, copy, or chain state, handle events, or notify parents in an Effect.
- Include all dependencies and symmetrical cleanup. Remounting must be safe.

## Memoization

- Use `useMemo` only for measured expensive pure work or required stable identity.
- Use `useCallback` only for a memoized child, Hook dependency, stable Hook API, or identity contract. A function prop alone is insufficient.
- Never memoize for correctness, side effects, cheap work, or routine handlers.
- If React Compiler provides the optimization, do not add manual `memo`, `useMemo`, or `useCallback`.

## Check

Name each Effect's external system and each memoization's consumer or measured benefit.
