# UI and E2E Tests

## Component Integration

- Maintain existing component integration tests for DOM behavior, accessibility, interactions, validation, and UI states.
- Query as a user would. Avoid component instances, internal state, private methods, and brittle selectors.
- Do not introduce a component-test layer unless requested.

## End to End

- With existing E2E infrastructure, every changed client-facing workflow requires E2E coverage. Update related tests during implementation without a separate request.
- Test the affected user journey and critical branches, not every visual component in isolation.
- Use the existing framework, semantic locators, web-first assertions, isolated data, and fixtures.
- Keep tests independent and verify user-visible outcomes rather than internal requests or state.
- If infrastructure is absent, add no dependencies or setup. At handoff, list exact scenarios and scope, then ask approval.
