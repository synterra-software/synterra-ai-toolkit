# Backend Product Composition

## Purpose

Keep backend behavior close to the domain context that owns its language, rules, data, and outcomes.
Most backend feature work should remain at this level.

## Responsibilities

Product-level backend work includes domain models, business rules, workflows, product-specific
validation, authorization policy, persistence decisions, integration mapping, and composition of
platform and shared capabilities.

## Composing Existing Capabilities

Compose framework features, platform foundations, and proven capabilities through their public
contracts. Use thin adapters to translate transport, persistence, or provider representations while
keeping domain policy visible in product code.

## Product-Specific Logic

Place invariants and decisions with the feature that owns them. Keep controllers, handlers, consumers,
and scheduled entry points focused on boundary translation and orchestration; keep domain behavior
testable without requiring the transport runtime when the existing architecture supports that split.

## When to Promote Repeated Behavior

Promote behavior only after multiple real uses establish a common meaning, meaningful variation, and
stable contract. Move the reusable mechanism while leaving product policy, vocabulary, and data
ownership at the product level.

## Common Failure Modes

- Organizing only by technical layer until one feature is scattered across the service.
- Putting business rules in controllers, message consumers, ORM hooks, or serializers.
- Sharing database entities as contracts between independent product areas.
- Adding a microservice boundary where a module boundary would satisfy the current requirement.
- Generalizing workflows whose consistency or failure semantics differ.
