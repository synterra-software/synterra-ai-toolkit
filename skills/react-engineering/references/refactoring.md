# React Refactoring

Apply the `software-engineering` refactoring workflow first.

## Structure

- Treat components over 400 lines with multiple responsibilities as God-component candidates; split by responsibility, not size alone.
- Move domain logic to domain modules, stateful reuse to Hooks, calculations to helpers, and independent UI to components.
- Replace complex render IIFEs with named components or helpers; keep simple expressions local.
- Use typed maps for stable dispatch, exhaustive `switch` for unions, and `if` for simple conditions.
- Extract repeated logic only when meaning and contract match.

## State and Effects

- Move frequently updated broad context state to the existing store with focused selectors; keep stable values in context.
- Replace Effect requests with the existing data layer; if absent, recommend one before adding it.
- Remove duplicated state and keep backend data in one server-state cache.

## TypeScript Hygiene

- Remove explicit `any` and aliases hiding it.
- Use `unknown` only at boundaries and narrow it before use.
- Prefer typed dependencies; otherwise add a minimal declaration or typed adapter and document gaps.
- Move reused or boundary types to domain-named `*.types.ts`; keep local types local.
- Remove verified unused code and test-only production paths.

## Check

Run strict types, lint, tests, and build; confirm unchanged behavior and contracts.
