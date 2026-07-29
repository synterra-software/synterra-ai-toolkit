# Frontend Platform

## Purpose

Define the stable frontend foundations shared across capabilities and product areas.

## Responsibilities

Frontend platform responsibilities may include:

- Application shell: root layout, navigation chrome, global providers, error boundaries
- Routing: route structure, guards, lazy-loaded route modules, URL conventions
- API client setup: HTTP or GraphQL client configuration, interceptors, generated-client wiring
- Authentication and session: token refresh, protected routes, session context
- Design tokens and UI primitives: theme, typography, spacing, base components
- State and server-cache setup: store configuration, query-client defaults, cache policies
- Internationalization: locale loading, message catalogs, date and number formatting
- Error reporting and monitoring: crash reporting, web vitals, frontend logging
- Testing setup: runners, render helpers, network mocks, E2E harness
- Accessibility foundations: focus management, landmarks, keyboard and ARIA conventions
- Performance: bundling, code splitting, asset loading, instrumentation
- Stable contracts and extension points for capabilities and product areas

These are platform concerns only when they provide a broadly shared foundation rather than support one product flow.

## When Platform Changes Are Justified

Change the platform when multiple current capabilities or product areas need the same stable foundation and existing extension points cannot support them cleanly. Define the contract, affected consumers, compatibility expectations, and broad verification before changing it.

Do not add platform machinery for hypothetical reuse or one feature's convenience.

## Extension Points

Prefer narrow, explicit extension points with stable inputs, outputs, and ownership. Use framework conventions, composition, contracts, or registered handlers already established by the application. Keep product policy outside the platform.

## Common Failure Modes

- Moving feature-specific behavior into the application shell.
- Replacing framework infrastructure without a concrete limitation.
- Creating global state or services for local concerns.
- Exposing unstable internals as public extension points.
- Changing foundations without validating affected consumers.
