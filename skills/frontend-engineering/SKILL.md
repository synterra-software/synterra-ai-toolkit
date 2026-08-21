---
name: frontend-engineering
description: Always use for any frontend application work — application shell, routing, design system, client state, data access, accessibility, performance, components, or shared frontend boundaries. Load it together with `software-engineering`, and load `react-engineering` and `nextjs-engineering` on top whenever those technologies are involved.
---

# Frontend Engineering

Apply `software-engineering` first, then this skill for every frontend change. Preserve the
application's framework, design system, dependency stack, architecture, and repository conventions. Always
load the matching framework skill on top when the work touches React, Next.js, or another framework — this
skill does not replace it.

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
