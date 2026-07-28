# State and Server Data

## Ownership

- Computable: derive during rendering.
- Component-only: local state or reducer.
- Form draft: React Hook Form.
- Stable, infrequently changed cross-tree: context. Context also injects per-screen dependencies into shared components; prefer a prop when only one level would pass it.
- Frequently changed shared client interaction: existing store with focused selectors.
- Backend-owned: existing server-state cache.

Never mirror backend entities. Drafts, payloads, optimistic layers, and rollback snapshots are temporary. Define sync ownership for offline or editor copies.

## Immutable Updates

- Use spread, `map`, or `filter` for simple updates; installed Immer for complex nested client state.
- If Immer is absent but materially simpler, recommend it before adding it.
- Use existing Zustand Immer middleware. Preserve unchanged references.
- Immer does not provide granular rendering; selectors and state boundaries do.
- Update backend data through its cache API, never an Immer-backed parallel store.

## Server Updates

- Keep the existing server-state library and use its native cache APIs.
- Optimistically update, reconcile the server result, and roll back failure.
- Refresh only affected data; respect identity, pagination, ordering, and filters.
- Real-time events update the same cache.

## Example

```tsx
// ❌ backend entity mirrored into local state — two owners
const { data } = useTodosQuery();
const [todos, setTodos] = useState(data);

// ✅ cache owns the data; derive the rest during render
const { data: todos } = useTodosQuery();
const visible = todos.filter((t) => !t.done);

// ✅ context as dependency injection behind a hook: one shared component, per-screen link target
const OrderLinkContext = createContext("/orders");
const useOrderLink = () => useContext(OrderLinkContext);

// each screen injects its destination once
<OrderLinkContext.Provider value="/admin/orders"><OrderTable /></OrderLinkContext.Provider>

// deep inside OrderTable — no prop drilled, no context type exposed
const href = useOrderLink();
return <Link to={href}>View order</Link>;
```

## Check

Verify ownership, focused subscriptions, optimistic reconciliation, rollback, and affected cache views.
