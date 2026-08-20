---
name: frontend-engineering
description: Use for framework-agnostic or cross-cutting frontend architecture involving the application shell, routing, design system, client state, data access, accessibility, performance, or shared frontend boundaries. Prefer React or Next.js skills for narrow framework-specific implementation.
---

# Frontend Engineering

Preserve the application's framework, design system, dependency stack, architecture, and repository
conventions. Use this skill for decisions that cross components or features; use the matching framework
skill when the work is local to React, Next.js, or another framework.

## Before Implementation

- Inspect the framework, project structure, application shell, routing, state, data access, design system, dependencies, and established feature patterns.
- Trace the affected user flow, UI states, failures, and integration boundaries.
- Do not rewrite working architecture without a concrete requirement.

For platform, shared-capability, and product ownership decisions, read
[Frontend Boundaries](references/frontend-boundaries.md).

## Implementation

- Follow repository and framework conventions.
- Reuse the design system, shared modules, and installed dependencies where they fit.
- Prefer framework-native capabilities before adding custom infrastructure.
- Add a dependency only when the existing stack does not cover the requirement and dependency changes are
  within scope.
- Keep product-specific behavior in product code instead of forcing a generic abstraction.
- Make the smallest coherent change that preserves existing architecture and behavior.

## Verification

- Verify the user-visible flow, state transitions, failure behavior, and integration boundaries.
- Run the framework and repository checks relevant to the changed area.
- Confirm reuse and ownership decisions still match the implemented behavior.
