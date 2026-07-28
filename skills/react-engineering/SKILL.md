---
name: react-engineering
description: Use when planning, implementing, or reviewing any React application change, especially work involving NiceModal modals, React Hook Form forms, client state, server-state caches, optimistic updates, or generated API clients.
---

# React Engineering

## Purpose

Apply consistent React patterns while preserving the repository's existing framework, UI library, data client, state tools, and generated API boundary.

## Relationship to Other Skills

Apply `software-engineering` and `frontend-engineering` first. This skill adds React-specific rules without replacing their guidance on scope, ownership, reuse, or verification.

## Before Implementation

- Inspect the React version, framework, package manager, application shell, providers, UI library, form patterns, client-state tools, server-state client, and API generation setup.
- Follow established repository conventions unless a React-specific rule requires a focused addition.
- Consult current official documentation for the installed or target versions before integrating a library.
- Apply these rules to new or explicitly changed code. Do not migrate working implementations outside the requested scope.

## Required References

Read every reference relevant to the task before planning or implementation:

- For a new or changed modal, read [Modals](references/modals.md).
- For user input or a form, read [Forms](references/forms.md).
- For local, shared, server, optimistic, subscription, or offline state, read [State and Server Data](references/state-and-server-data.md).
- For backend integration, generated clients, GraphQL, REST, OpenAPI, or Swagger, read [API Boundary](references/api-boundary.md).

Read multiple references when a task crosses those concerns.

## Core Invariants

- Build new modals with NiceModal and new data-entry flows with React Hook Form.
- Give each state value one authoritative owner. Never maintain backend-owned data in parallel stores.
- Keep backend data in the repository's established server-state cache, independent of the chosen library.
- Never edit generated API code manually.
- Do not rewrite existing modals or unrelated React architecture unless the task explicitly requests it.

## Verification

- Re-read the applicable references and verify every relevant rule against the implementation.
- Run the narrowest relevant tests, type checks, linting, and build checks for the changed React area.
