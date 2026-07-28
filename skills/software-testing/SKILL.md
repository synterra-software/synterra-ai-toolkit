---
name: software-testing
description: Use when implementing, fixing, refactoring, reviewing, or testing software to select required unit, component integration, and end-to-end coverage.
---

# Software Testing

Cover changed behavior at the lowest useful level and preserve affected workflows.

## Workflow

1. Inspect existing tools, commands, helpers, coverage, and nearby tests.
2. Map changes to platform, capability, and product ownership tiers.
3. Read [Unit Tests](references/unit-tests.md) for changed logic.
4. Read [UI and E2E Tests](references/ui-and-e2e-tests.md) for client-facing behavior.
5. Update affected tests during implementation.
6. Run narrow checks, then affected suites and coverage checks.

## Required Coverage

- Unit-test changed business logic, state transitions, validators, and transformations.
- Never unit-test component implementation details.
- Maintain component integration tests when the repository uses them.
- Cover every changed client-facing workflow with E2E tests when E2E infrastructure exists.
- Do not add E2E infrastructure without approval. If absent, verify what exists, propose exact scenarios, and ask once.

## Handoff

Report the implementation; platform/capability/product tiers touched; tests by level; commands and results; gaps; and E2E scenarios requiring approval.
