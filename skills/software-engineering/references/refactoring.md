# Refactoring

Refactoring preserves behavior unless the task explicitly changes it.

## Baseline

- Read architecture and structure; identify behavior, responsibilities, contracts, and dependency direction.
- Run tests, types, lint, and build; characterize unprotected behavior before editing.
- Follow the repository's existing testing practices and coverage expectations.

## Structure

- Keep modules cohesive, dependencies directional, and responsibilities explicit.
- Remove unreachable code and obsolete tests after checking exports, configuration, dynamic loading, and reflection.
- Code used only by tests is dead unless it supports a public contract.
- Extract repeated business logic only with one stable meaning and contract.
- Move shared or boundary types to domain-named files; keep single-use types local.
- Name extracted files by domain and role, such as `task.types.ts`, `task.constants.ts`, or `task.utils.ts`.

## Execute

- Refactor in small verified steps.
- Exclude unrelated behavior, formatting, and speculative abstractions.
- Finish with full checks and contract and dependency review.
