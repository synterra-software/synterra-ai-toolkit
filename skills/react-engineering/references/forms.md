# Forms

## Rules

- Use React Hook Form for forms and data-entry flows. Do not maintain form values as parallel component state.
- Treat user input as a form by default when it is submitted, validated, has errors, tracks dirty state, or contains related fields.
- Local state is acceptable for a single lightweight search, filter, or instant control that has no submission, validation, or form lifecycle.
- Use `register` for inputs that expose compatible native input and ref behavior.
- Use `Controller` or `useController` for controlled UI-library fields.
- Prefer a compatible integration already used by the repository.
- If the UI library has a maintained integration recommended by current official documentation, use it. Otherwise, create a thin reusable field adapter with `Controller` or `useController`.
- Keep unsaved values in React Hook Form until submission. After submission, let the mutation and server-state layer own synchronization.

## Verification

- Confirm there is no parallel React state for form values.
- Exercise validation, submission, backend errors, dirty state, reset behavior, and disabled or pending behavior that apply to the form.
- Confirm controlled UI-library fields correctly connect value, change, blur, ref, and error state.
