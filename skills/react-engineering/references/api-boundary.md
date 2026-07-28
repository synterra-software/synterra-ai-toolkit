# API Boundary

## Generation

- Generate GraphQL types and operations from the backend schema using the repository's code-generation setup.
- Generate REST clients from the backend OpenAPI or Swagger specification using the repository's generator.
- Never edit generated API code manually.
- Change the source specification or generator configuration, then run the documented generation command.
- If the required specification or generation command is missing, report the gap instead of hand-writing a replacement client.

## Application Boundary

- Keep generated clients and server-state library details behind an application-owned data or domain boundary.
- Components should consume application-facing hooks or functions instead of transport clients directly.
- Let the boundary own domain mapping, cache policy, optimistic behavior, and application-level error handling.
- Avoid speculative layers that have no boundary or behavior to protect.
- Keep authentication, transport configuration, and middleware outside individual components.
- Consult current official documentation for the schema tools, generator, generated client, and server-state library versions used by the repository.

## Verification

- Run the documented generation command and confirm its output is reproducible.
- Confirm generated files were not edited manually.
- Confirm components do not couple directly to transport configuration or generated client internals.
- Exercise the application-facing hooks or functions across success, loading, and relevant error behavior.
