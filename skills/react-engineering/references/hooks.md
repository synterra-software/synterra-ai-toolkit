# Hooks

## Rules

- Follow Hooks lint rules; never suppress dependency warnings.
- Keep Hooks pure. Derive during rendering; run interaction logic in its handler.

## `useEffect`

- Prefer Effects for lifecycle-bound external synchronization: subscriptions, timers, browser APIs,
  imperative widgets, or a resource whose lifetime is owned by the mounted component.
- Prefer the framework or existing server-state layer for application queries. An Effect-based request is
  acceptable only when component lifecycle genuinely owns it and no established data abstraction does;
  handle cancellation, stale responses, remounting, loading, and errors explicitly.
- Trigger interaction mutations from their event handler or the repository's mutation layer.
- Derive values during rendering and handle interactions in their handler. Use an Effect for parent
  notification only when it represents synchronization with an external owner rather than derived state.
- Never mirror props into local state and resync them with an Effect. Derive during render; reset with `key`; if a prop only seeds state, name it `initialX` and ignore later changes.
- Include all dependencies and symmetrical cleanup. Remounting must be safe.

```tsx
// ❌ state synchronized through an Effect
const [total, setTotal] = useState(0);
useEffect(() => { setTotal(items.reduce((s, i) => s + i.price, 0)); }, [items]);
// ✅ derive during render
const total = items.reduce((s, i) => s + i.price, 0);

// ❌ query in an Effect
useEffect(() => { api.getUser(id).then(setUser); }, [id]);
// ✅ existing data layer
const { data: user } = useUserQuery(id);

// ❌ prop mirrored into state and resynced by an Effect
const [draft, setDraft] = useState(item);
useEffect(() => { setDraft(item); }, [item]);
// ✅ seed once and reset intentionally via key
<ItemEditor key={item.id} initialItem={item} />
```

## Memoization Hooks

- Use `useMemo` only for measured expensive pure work or required stable identity.
- Use `useCallback` only for a memoized child, Hook dependency, stable Hook API, or identity contract. A function prop alone is insufficient.
- Never memoize for correctness, side effects, cheap work, or routine handlers.
- If React Compiler provides the optimization, do not add manual `useMemo` or `useCallback`.

## Check

Name each Effect's external system and each memoization Hook's consumer or measured benefit.
