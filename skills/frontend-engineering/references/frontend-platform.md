# Frontend Platform

## Purpose

Define the stable frontend foundations shared across capabilities and product areas.

## Responsibilities

Frontend platform responsibilities may include:

- Application shell
- Routing infrastructure
- API client infrastructure
- Authentication and session infrastructure
- Design tokens and foundational UI primitives
- State and caching infrastructure
- Internationalization infrastructure
- Error reporting and observability
- Testing infrastructure
- Accessibility foundations
- Performance instrumentation
- Stable contracts and extension points

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
