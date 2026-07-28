---
name: software-engineering
description: Use when planning, specifying, architecting, implementing, or reviewing software changes that require decisions about scope, ownership, reuse, or verification.
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

## Implementation

- Prefer existing capabilities, dependencies, and established solutions over custom infrastructure.
- Implement at the most product-specific level that can own the behavior cleanly.
- Avoid speculative abstractions and flexibility without a current requirement.
- Extract reusable capabilities only after real repetition and meaningful variation are understood.
- Make the smallest coherent change that satisfies the requirement.

## Verification

- Verify observable behavior, not only implementation details.
- Run the narrowest relevant checks, then any broader checks needed for affected contracts.
- Compare results with the acceptance criteria and report anything that was not verified.

## References

- [Development Model](references/development-model.md)
- [Specification-Driven Development](references/specification-driven-development.md)
