# Frontend Boundaries

Use the most specific ownership level that satisfies current requirements.

## Product

Keep product pages, workflows, validation, copy, domain terminology, and unique UI states with the feature
that owns them. Compose the existing framework, design system, and shared capabilities directly. A single
consumer or uncertain variation is not a reason to create shared infrastructure.

## Capability

Extract a shared frontend capability only when multiple real flows have the same interaction contract and
known variation. Forms, tables, uploads, search, permissions, reporting, and repeated workflows may qualify,
but only when sharing clarifies rather than hides product behavior.

Expose the smallest stable surface through props, schemas, composition, policies, or handlers. Avoid broad
configuration objects, unrelated flags, hidden control flow, and product terminology in shared APIs.

## Platform

Treat the application shell, global providers, routing foundations, API-client setup, auth/session plumbing,
design tokens, state/cache configuration, i18n, monitoring, accessibility foundations, testing harness, and
build/performance configuration as platform only when multiple current product areas depend on them.

Platform changes require stable extension points, compatibility across consumers, and broader verification.
Do not move one feature's state, policy, or convenience wrapper into global infrastructure.

## Check

Confirm the change is owned by the narrowest viable level, product policy remains visible, and any shared
contract is supported by current consumers rather than hypothetical reuse.
