# React Refactoring

Apply the `software-engineering` refactoring workflow first.

## Structure

- Split components by responsibility, not line count. Signals: unrelated state clusters, Effects serving different concerns, pass-through props, JSX sections that change independently.
- Separate logic from presentation: domain rules in domain modules, stateful logic in custom Hooks, pure calculations in plain helpers, independent UI in components.
- Keep state in the lowest component that uses it; lift only when actually shared. Pass JSX as `children` instead of drilling props.
- Model variants with composition or discriminated props, not accumulating boolean flags.
- Replace complex render IIFEs with named components or helpers; keep simple expressions local.
- Use typed maps for stable dispatch, exhaustive `switch` for unions, and `if` for simple conditions.
- Extract repeated logic only when meaning and contract match.
- Remove verified unused code and test-only production paths.

## Example

```tsx
// ❌ render IIFE with branching
{(() => { switch (block.kind) { /* ... */ } })()}

// ✅ typed map dispatch to named components
const blockViews = { text: TextBlock, image: ImageBlock } satisfies Record<Block["kind"], FC<BlockProps>>;
const BlockView = blockViews[block.kind];
```

## Related Rules

When refactoring those concerns, also apply [Components](components.md), [Hooks](hooks.md), [State and Server Data](state-and-server-data.md), and [TypeScript](typescript.md).

## Check

Run strict types, lint, tests, and build; confirm unchanged behavior and contracts.
