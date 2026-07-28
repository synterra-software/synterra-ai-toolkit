---
name: frontend-engineering
description: Use when planning, architecting, implementing, or reviewing frontend application changes within an existing framework, design system, dependency stack, or repository conventions.
---

# Frontend Engineering

## Purpose

Apply sound software engineering decisions to frontend work while respecting the application already in place.

## Relationship to Software Engineering

Apply the `software-engineering` skill first for outcome definition, specification depth, ownership, implementation scope, and verification. This skill adds frontend-specific decisions without redefining that guidance.

## Before Implementation

- Inspect the framework, project structure, application shell, routing, state, data access, design system, dependencies, and established feature patterns.
- Trace the affected user flow, UI states, failures, and integration boundaries.
- Decide whether the change belongs to product composition, a proven reusable capability, or the frontend platform.
- Do not rewrite working architecture without a concrete requirement.

## Frontend Ownership Model

Keep most feature work in product code. Reuse capabilities for recurring frontend behavior with understood variation. Change the platform only for stable foundations shared across multiple capabilities or product areas.

## Reuse Order

Use the first option that cleanly satisfies the requirement:

1. Existing project implementation
2. Existing design system or shared module
3. Framework-native capability
4. Existing project dependency
5. Mature ecosystem library
6. Small custom implementation

Framework-aware means using the current framework's established patterns and native solutions, not ignoring the framework to pursue generic code.

## Implementation

- Follow repository and framework conventions.
- Reuse the design system, shared modules, and installed dependencies where they fit.
- Avoid adding a dependency when the existing stack already covers the requirement.
- Avoid recreating mature ecosystem solutions.
- Keep product-specific behavior in product code instead of forcing a generic abstraction.
- Make the smallest coherent change that preserves existing architecture and behavior.

## Verification

- Verify the user-visible flow, state transitions, failure behavior, and integration boundaries.
- Run the framework and repository checks relevant to the changed area.
- Confirm reuse and ownership decisions still match the implemented behavior.

## References

- [Frontend Platform](references/frontend-platform.md)
- [Frontend Capabilities](references/frontend-capabilities.md)
- [Frontend Product Composition](references/frontend-product-composition.md)
