# Hooks

## Rules

- Follow Hooks lint rules; never suppress dependency warnings.
- Keep Hooks pure. Derive during rendering; run interaction logic in its handler.

## `useEffect`

- Use only for external synchronization: subscriptions, timers, browser APIs, or imperative widgets.
- Never issue application queries or mutations from an Effect.
- Use the existing data or framework layer; trigger interaction mutations from their handler.
- If no data layer exists, recommend one before adding it.
- Never derive, copy, or chain state, handle events, or notify parents in an Effect.
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
