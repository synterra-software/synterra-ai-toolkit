# React Refactoring

Apply the `software-engineering` refactoring workflow first.

## Structure

- Treat components over 400 lines with multiple responsibilities as God-component candidates; split by responsibility, not size alone.
- Move domain logic to domain modules, stateful reuse to Hooks, calculations to helpers, and independent UI to components.
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
