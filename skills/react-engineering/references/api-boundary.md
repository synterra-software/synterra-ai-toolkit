# API Boundary

## Rules

- Generate GraphQL types and operations from the backend schema.
- Generate REST clients from the OpenAPI or Swagger specification.
- Never edit generated code. Change its source or generator, then regenerate.
- If the specification or generation command is missing, report it. Do not hand-write a replacement client.
- Components use application hooks or functions, not transport clients directly.
- The application boundary owns mapping, caching, optimistic updates, and errors.
- Keep authentication, transport configuration, and middleware outside components.
- Add no pass-through abstraction without a boundary to protect.

## Example

```tsx
// ❌ transport client inside the component
const user = await generatedApi.getUser(id);

// ✅ application hook owns mapping, cache policy, and errors
const { data: user } = useUser(id); // wraps the generated client in the data layer
```

## Check

Regenerate successfully and test the application boundary's loading, success, and error paths.
