---
name: react-engineering
description: Use for React-specific components, hooks, effects, forms, modals, client state, server-state integration, optimistic updates, TypeScript props, and component refactoring. For Next.js routing, rendering, caching, or RSC behavior, use the Next.js skill instead.
---

# React Engineering

Preserve the repository's React version, framework integration, component conventions, design system,
form/modal libraries, and state/data stack. Change only requested or new code unless migration is in scope.

## Read Before Work

- Modal: [Modals](references/modals.md)
- User input or form: [Forms](references/forms.md)
- Hooks, Effects, requests, `useMemo`, `useCallback`: [Hooks](references/hooks.md)
- Components, props, `memo`: [Components](references/components.md)
- TypeScript types and safety: [TypeScript](references/typescript.md)
- Client or server state: [State and Server Data](references/state-and-server-data.md)
- Backend or generated API integration: [API Boundary](references/api-boundary.md)
- React refactoring: [Refactoring](references/refactoring.md)

Read every matching reference.

## Core rules

- Reuse the project's established modal and form solutions. When none exists, prefer NiceModal for modals
  and React Hook Form for complex submitted forms. Add a dependency only when that change is in scope;
  otherwise propose it and explain the tradeoff.
- Follow the repository's component declaration style and type props explicitly. Memoize only for a
  concrete benefit.
- Prefer the framework or existing server-state layer for application data. Use Effects for lifecycle-bound
  synchronization when no owning framework/data abstraction exists.
- Give every value one owner. Keep backend data in the existing server-state cache.
- Never edit generated API code.
- Do not migrate existing code unless requested.
- Test changed behavior following the repository's existing testing practices.

## Check

Apply every matching rule, then run relevant tests, type checks, linting, and builds.
