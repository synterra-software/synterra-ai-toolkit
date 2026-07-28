# TypeScript Components

## Components and Props

- Write new React components as functional components.
- Use `FC<ComponentProps>` as the default team convention, with a descriptive named props type.
- Use a typed function declaration when a generic component or framework API cannot be expressed cleanly with `FC`.
- Declare `children` explicitly as `ReactNode` or a narrower supported type only when the component accepts it.
- Reuse native element props with `ComponentPropsWithoutRef` or the repository's equivalent instead of re-declaring DOM attributes.
- Let TypeScript infer local values, inline event parameters, Hook return types, and obvious state types. Add explicit types at component and integration boundaries or when inference is incomplete.
- Use discriminated unions for mutually exclusive component variants and UI states. Do not model impossible combinations with unrelated optional booleans.
- Narrow unknown values instead of using `any`, unsafe assertions, or non-null assertions to silence errors.
- Use `satisfies` for typed constant maps or configuration when validation should preserve useful literal inference.

## Component Memoization

- Inspect React Compiler configuration before adding manual `memo`.
- Use `memo` only when a component renders often with unchanged props and skipping its render avoids meaningful work.
- Do not use `memo` for correctness or as a default wrapper for every component.
- A `children` prop does not automatically forbid `memo`, but newly created JSX often changes identity and defeats its shallow comparison.
- Keep props minimal and stable before adding custom comparison logic. Use a custom comparator only after profiling proves it is cheaper than rendering, and compare every prop including functions.

## Verification

- Run the repository's strict type check and React lint rules.
- Confirm component props prevent invalid combinations and do not weaken generated or external types.
- Confirm every manual `memo` has stable props and a concrete measured or architectural benefit.
