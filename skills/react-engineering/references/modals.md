# Modals

## Rules

- Reuse the repository's established modal manager and design-system dialog primitives.
- When no modal pattern exists, prefer `@ebay/nice-modal-react` for programmatic or cross-tree modals. Add
  it only when dependency changes are within scope; otherwise propose it and explain the tradeoff.
- With NiceModal, mount one provider at the appropriate client boundary and use the UI-library adapter when
  available; otherwise create the smallest lifecycle adapter.
- Do not migrate existing modals unless requested.
- If the preferred solution is incompatible with the framework, rendering model, or design system, preserve
  the compatible project architecture and report the tradeoff.

## Example

```tsx
const ConfirmDeleteModal = NiceModal.create<{ name: string }>(({ name }) => {
  const modal = useModal();
  return (
    <Dialog open={modal.visible} onClose={modal.hide} onTransitionExited={modal.remove}>
      <Button onClick={() => { modal.resolve(true); modal.hide(); }}>Delete {name}</Button>
    </Dialog>
  );
});

// Caller: no local open/close state.
const confirmed = await NiceModal.show(ConfirmDeleteModal, { name: item.name });
```

## Check

Test open, confirm, cancel, programmatic close, and transition cleanup that apply.
