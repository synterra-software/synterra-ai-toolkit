# Frontend Product Composition

## Purpose

Keep frontend behavior close to the product context that owns its language, rules, and outcomes. Most frontend feature work should remain at this level.

## Responsibilities

Product-level frontend work includes:

- Product-specific pages
- Domain terminology
- Business rules
- Product workflows
- Product-specific validation
- Feature configuration
- Composition of a platform and shared capabilities
- Small amounts of unique behavior

## Composing Existing Capabilities

Build product flows by composing the application platform, framework-native features, design-system components, and proven capabilities. Add thin product adapters when contracts need translation, but keep domain policy visible in product code.

## Product-Specific Logic

Place product rules, orchestration, validation, copy, and unique UI states with the feature that owns them. Prefer direct, readable composition over generic configuration that hides the product flow.

## When to Promote Repeated Behavior

Promote behavior only after multiple real product uses establish a common core, meaningful variation, and a stable public contract. Move the reusable mechanism while leaving product policy and terminology at the product level.

## Common Failure Modes

- Treating every repeated component as a shared capability.
- Moving domain rules into platform services or generic UI.
- Adding broad configuration to avoid a small product-specific implementation.
- Duplicating an established framework, design-system, or shared solution.
- Rewriting architecture to make one feature appear generic.
