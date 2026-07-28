# Components

## Components and Props

- Use functional components with `FC<ComponentProps>` and a descriptive props type.
- Use a typed function for generics or framework APIs that `FC` cannot express cleanly.
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

const UserCard: FC<UserCardProps> = ({ user, children, ...rest }) => (
  <div {...rest}>{user.name}{children}</div>
);

// ❌ memo defeated: children JSX gets a new identity every render
<MemoizedList>{items.map(renderItem)}</MemoizedList>
```

## Check

Confirm the props contract and that each `memo` has stable props and a concrete benefit.
