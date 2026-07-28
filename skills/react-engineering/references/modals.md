# Modals

## Rules

- Build every new React modal with `@ebay/nice-modal-react`.
- If the package is absent, install a version compatible with the application and its React version using the repository's package manager.
- Ensure `NiceModal.Provider` wraps the appropriate application or client boundary. Reuse an existing provider when present.
- Consult current NiceModal and UI-library documentation for the installed or target versions before integration.
- Use NiceModal's supported adapter for the current UI library when one exists.
- Otherwise, create the smallest adapter that maps the UI library's visibility, close, and transition lifecycle to NiceModal.
- Do not rewrite existing modals unless the task explicitly requests their migration.
- If the application environment cannot support NiceModal safely, report the compatibility conflict instead of silently introducing another modal pattern.

## Verification

- Confirm the provider is mounted at the correct React client boundary.
- Exercise open, confirm, cancel, programmatic close, and transition cleanup behavior that applies to the modal.
- Confirm new modal code uses NiceModal and the chosen UI-library adapter correctly.
