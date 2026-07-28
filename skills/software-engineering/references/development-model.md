# Development Model

## Purpose

Use three ownership tiers to place changes where they serve current requirements without creating premature shared infrastructure.

## Platform

Platform is stable foundational infrastructure shared broadly. It includes runtime infrastructure, protocols, storage, security, observability, stable contracts, extension points, and testing infrastructure.

Platform changes should be rare, deliberate, compatible with broad use, and validated across affected consumers.

## Capabilities

Capabilities are reusable, parameterized implementations of recurring functionality, such as authentication, payments, workflows, notifications, permissions, reporting, and integrations.

A capability should represent a family of real scenarios. Configure variation through clear contracts, schemas, policies, composition, or handlers. Do not create a generic capability from imagined future reuse.

## Product

Product contains domain models, business rules, configuration, workflows, composition, and unique behavior for a specific product or feature. Most feature work should remain here because this is where its requirements and vocabulary are owned.

## Selecting the Correct Tier

> Implement the requirement at the most product-specific level that can own it cleanly.

- Keep unique behavior in product code.
- Use a capability when multiple real product scenarios share behavior but require known variation.
- Change platform only when several capabilities or product areas need the same stable foundation.

## Moving Responsibilities Between Tiers

Move responsibility upward only when evidence establishes a stable shared need. Preserve explicit contracts and keep product policy outside lower tiers.

> Promote behavior into a reusable capability only after repetition, common behavior, and meaningful variation are understood.

## Common Failure Modes

- Adding platform machinery for one feature.
- Hiding product rules inside shared infrastructure.
- Generalizing after copy-and-paste repetition without understanding variation.
- Building configuration for hypothetical consumers.
- Keeping broadly shared behavior duplicated after its stable contract is clear.
