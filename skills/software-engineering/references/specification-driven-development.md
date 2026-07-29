# Specification-Driven Development

## Purpose

Define enough expected behavior and ownership to guide implementation and verification without turning minor work into a documentation project.

## When a Specification Is Required

Specify before implementation whenever behavior changes. The specification may be a few bullets for a small change. Increase depth when scope, states, business rules, contracts, or architectural ownership are uncertain or consequential.

## Small Change Specification

Include only:

- Current behavior
- Expected behavior
- Acceptance criteria
- Important edge cases

## Feature Specification

Include:

- Goal
- Non-goals
- User or system flow
- Functional requirements
- States and failure behavior
- Business rules
- Data contracts
- Existing capabilities to reuse
- Architectural ownership
- Acceptance criteria
- Test approach

Omit an item only when it is genuinely irrelevant, not merely undecided.

## Architectural Changes

Explain why the existing ownership or contracts cannot support the requirement. Identify affected tiers, consumers, compatibility constraints, and how the change will be validated. Prefer a product-level solution unless broader ownership is justified by current use.

## Acceptance Criteria

Write criteria as observable, testable outcomes. Cover the primary flow, relevant failures, and boundaries that determine completion. Avoid criteria that only name internal implementation choices.

## Handling Missing Information

Separate blocking decisions from safe assumptions. Ask for decisions that would materially change behavior, scope, data, or ownership. State any safe assumption explicitly and update the specification when new information changes it.
