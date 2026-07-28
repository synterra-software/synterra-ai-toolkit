# Unit Tests

- Test logic, not components: domain rules, services, validators, transformations, reducers, stores, and state transitions.
- Assert public behavior, contracts, edge cases, failures, and critical invariants; avoid private implementation details.
- Add a regression test before fixing a reproducible bug.
- Mock only external boundaries such as network, time, storage, and randomness.
- Keep tests deterministic, focused, and named by behavior.
- Core/domain modules touched by refactoring require at least 90% line and branch coverage. Coverage does not replace invariant tests.
- Do not use shallow rendering or snapshot-only assertions as unit coverage for UI components.
- Reuse the repository runner, fixtures, factories, and conventions. Do not add another framework without approval.
