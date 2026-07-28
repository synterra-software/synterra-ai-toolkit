# TypeScript

## Rules

- Infer locals, inline events, Hook returns, and obvious state; type boundaries explicitly.
- Use discriminated unions for exclusive props and UI states.
- Use `unknown` only at boundaries and narrow it before use.
- Avoid explicit `any`, aliases hiding it, unsafe casts, and non-null assertions.
- Use `satisfies` for typed constants that need literal inference.
- Prefer typed dependencies. Otherwise add a minimal declaration or typed adapter and document gaps.
- Move reused or boundary types to domain-named `*.types.ts`; keep single-use types local.

## Example

```tsx
type ReportState =                       // exclusive states, not optional-boolean soup
  | { kind: "loading" }
  | { kind: "error"; message: string }
  | { kind: "ready"; data: Report };

const config = { retries: 3, mode: "fast" } satisfies UploadConfig; // keeps literals

const parsed: unknown = JSON.parse(raw);
if (isReport(parsed)) render(parsed);    // narrow, don't cast
```

## Check

Run strict type checks and confirm every boundary is typed and narrowed.
