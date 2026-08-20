# Components

## Components and Props

- Follow the repository's function-declaration or typed-constant convention for components.
- Type props explicitly. Use `FC` only when it is the established convention or provides a concrete benefit;
  use a typed function when generics or framework APIs are clearer without it.
- Type `children` explicitly. Extend native props with `ComponentPropsWithoutRef`.

## `memo`

- Use only when frequent renders with stable props skip meaningful work.
- Do not use for correctness or as a default wrapper.
- `children` is allowed, but new JSX usually defeats shallow comparison.
- Prefer stable props. Profile custom comparators and compare every prop.
- Do not add manual `memo` when React Compiler provides it.

## Example

```tsx
type UserCardProps = ComponentPropsWithoutRef<"div"> & {
  user: User;
  children?: ReactNode;
};

function UserCard({ user, children, ...rest }: UserCardProps) {
  return <div {...rest}>{user.name}{children}</div>;
}

// ❌ memo defeated: children JSX gets a new identity every render
<MemoizedList>{items.map(renderItem)}</MemoizedList>
```

## Check

Confirm the props contract and that each `memo` has stable props and a concrete benefit.
