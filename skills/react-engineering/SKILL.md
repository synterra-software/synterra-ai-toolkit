---
name: react-engineering
description: Use for React and TypeScript components, hooks, memoization, modals (NiceModal), forms (React Hook Form), state, server data, optimistic updates, generated API clients, and refactoring.
---

# React Engineering

Apply `software-engineering` and `frontend-engineering` first. Preserve the existing stack, check current official docs, and change only requested or new code.

## Read Before Work

- Modal: [Modals](references/modals.md)
- User input or form: [Forms](references/forms.md)
- Hooks, Effects, requests, memoization: [Hooks](references/hooks.md)
- Components, props, TypeScript: [TypeScript Components](references/typescript-components.md)
- Client or server state: [State and Server Data](references/state-and-server-data.md)
- Backend or generated API integration: [API Boundary](references/api-boundary.md)
- React refactoring: [Refactoring](references/refactoring.md)

Read every matching reference.

## Non-Negotiable

- New modals use NiceModal. New data-entry flows use React Hook Form. These team standards
  override the frontend reuse order; install either if missing.
- Use typed functional components. Memoize only for a concrete benefit.
- Effects only synchronize external systems; never issue requests from them.
- Give every value one owner. Keep backend data in the existing server-state cache.
- Never edit generated API code.
- Do not migrate existing code unless requested.
- Test changed behavior following the repository's existing testing practices.

## Check

Apply every matching rule, then run relevant tests, type checks, linting, and builds.
