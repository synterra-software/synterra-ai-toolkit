# TypeScript Components

## Rules

- Use functional components with `FC<ComponentProps>` and a descriptive props type.
- Use a typed function for generics or framework APIs that `FC` cannot express cleanly.
- Type `children` explicitly. Extend native props with `ComponentPropsWithoutRef`.
- Infer locals, inline events, Hook returns, and obvious state; type boundaries explicitly.
- Use discriminated unions for exclusive props and UI states.
- Narrow unknown values; avoid `any`, unsafe casts, and non-null assertions.
- Use `satisfies` for typed constants that need literal inference.

## `memo`

- Use only when frequent renders with stable props skip meaningful work.
- Do not use for correctness or as a default wrapper.
- `children` is allowed, but new JSX usually defeats shallow comparison.
- Prefer stable props. Profile custom comparators and compare every prop.
- Do not add manual `memo` when React Compiler provides it.

## Check

Run strict type checks; confirm each `memo` has stable props and a concrete benefit.
