---
name: software-engineering
description: Always use for any software work — planning, specifying, architecting, implementing, refactoring, reviewing, or verifying a change. Load it for every engineering task, then load the matching frontend, backend, and framework skills on top of it.
---

# Software Engineering

## Purpose

Deliver the desired outcome through the smallest coherent, well-owned change that can be verified in the existing system.

## Core Approach

1. Understand the observable outcome and constraints.
2. Inspect the relevant system before proposing changes.
3. Specify only what the task needs.
4. Reuse established capabilities and solutions where they fit.
5. Place behavior at the most specific ownership level that can support it cleanly.
6. Implement, then verify the outcome against acceptance criteria.

## Before Implementation

- Clarify the desired behavior, constraints, and success criteria.
- Trace the affected paths, conventions, dependencies, and existing capabilities.
- Identify decisions that would materially change scope or architecture. Surface them instead of guessing.

## Specification

Match specification depth to task complexity. Use a short behavior-focused specification for a small change and a fuller specification for a feature or architectural change. Read [Specification-Driven Development](references/specification-driven-development.md) when defining scope, behavior, or acceptance criteria.

## Development Model

Classify ownership as platform, capability, or product. Most feature work belongs at the product level. Read [Development Model](references/development-model.md) when selecting an ownership tier or considering reuse.

## Refactoring

Read [Refactoring](references/refactoring.md) before any behavior-preserving restructuring, cleanup, decomposition, or dead-code removal.

## Implementation

- Prefer existing capabilities, dependencies, and established solutions over custom infrastructure.
- Implement at the most product-specific level that can own the behavior cleanly.
- Avoid speculative abstractions and flexibility without a current requirement.
- Extract reusable capabilities only after real repetition and meaningful variation are understood.
- Make the smallest coherent change that satisfies the requirement.

## Verification

- Follow the repository's existing testing practices; keep affected existing tests current.
- Verify observable behavior, not only implementation details.
- Run the narrowest relevant checks, then any broader checks needed for affected contracts.
- Compare results with the acceptance criteria and report anything that was not verified.

## References

- [Development Model](references/development-model.md)
- [Refactoring](references/refactoring.md)
- [Specification-Driven Development](references/specification-driven-development.md)
