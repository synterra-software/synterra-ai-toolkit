# Frontend Capabilities

## Purpose

Represent recurring frontend functionality with a stable shared core and explicit, understood variation.

## Responsibilities

Capabilities may cover:

- Forms
- Data tables
- Search and filtering
- File uploads
- Notifications
- Permissions
- Reporting
- Import and export
- Reusable workflows
- Repeated data-management flows

A capability owns reusable interaction behavior and contracts, not the product rules that happen to use it.

## When to Create a Capability

Extract a capability only after multiple real use cases reveal common behavior and meaningful variation. Confirm that sharing reduces duplication without obscuring product intent or fighting the framework and design system.

## Configuration and Extension

Express known variation through the smallest clear public surface, such as:

- Props or inputs
- Schemas
- Metadata
- Policies
- Composition
- Handlers
- Stable public contracts

Prefer composition and explicit contracts over growing sets of conditional flags.

## When Not to Generalize

Keep behavior at the product level when it has one consumer, uncertain variation, domain-specific rules, or a shape that differs materially between use cases. Do not build a universal component for imagined consumers.

## Common Failure Modes

- Extracting after superficial duplication without comparing behavior.
- Accumulating flags and callbacks for unrelated use cases.
- Hiding control flow or side effects behind generic APIs.
- Embedding product terminology and policy in shared components.
- Reimplementing framework, design-system, or ecosystem capabilities.
