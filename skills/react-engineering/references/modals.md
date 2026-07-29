# Modals

## Rules

- Build every new modal with `@ebay/nice-modal-react`.
- If missing, install a React-compatible version with the repository's package manager.
- Mount one `NiceModal.Provider` at the appropriate client boundary.
- Use NiceModal's adapter for the UI library when available. Otherwise create the smallest lifecycle adapter.
- Do not migrate existing modals unless requested.
- If NiceModal is incompatible, report the conflict. Do not introduce another pattern silently.

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
