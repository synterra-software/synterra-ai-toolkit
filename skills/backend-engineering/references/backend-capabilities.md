# Backend Capabilities

## Purpose

Represent recurring backend functionality with a stable shared core and explicit, understood variation.

## Responsibilities

Capabilities may cover authentication, permissions, notifications, payments, file processing, search,
reporting, imports, exports, webhooks, integrations, background workflows, and audit history.

A capability owns reusable behavior and contracts, not the product rules that happen to use it.

## When to Create a Capability

Extract a capability only after multiple real scenarios reveal common behavior and meaningful variation.
Confirm that sharing clarifies ownership and reduces duplication without hiding product policy or coupling
unrelated data and failure modes.

## Configuration and Extension

Express known variation through the smallest clear surface: typed inputs, policies, schemas, adapters,
handlers, events, or composition. Make side effects, consistency guarantees, and failure behavior part of
the contract.

## When Not to Generalize

Keep behavior at the product level when it has one consumer, uncertain variation, domain-specific rules,
or materially different transaction and failure semantics. Do not build a generic service for imagined
consumers.

## Common Failure Modes

- Sharing code while data ownership and business meaning remain different.
- Hiding domain policy behind generic configuration or boolean flags.
- Creating a common integration abstraction before two providers have proven common semantics.
- Treating a shared database table as a stable capability contract.
- Reimplementing framework, database, queue, or ecosystem capabilities.
