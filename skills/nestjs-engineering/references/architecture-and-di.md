# Architecture and Dependency Injection

## Feature Modules

- Follow the repository's existing feature boundaries and naming. Keep controllers, providers, DTOs,
  and feature-specific adapters close to the module that owns them.
- Import a module to consume its exported providers. Export only the smallest stable surface required by
  current consumers.
- Use global modules and global enhancers only for true application-wide infrastructure.
- Preserve platform-specific dynamic module patterns such as `forRoot` and `forFeature` when already
  established; do not introduce them for a single static feature.

## Providers

- Use constructor injection so dependencies and test seams are visible.
- Keep tokens explicit for interfaces, configuration, factories, and multiple implementations.
- Prefer singleton scope. Request scope propagates through the dependency graph and adds per-request
  construction; use it only for state that cannot be passed explicitly or carried by established request
  context.
- Use factories for runtime construction and configuration, not service locators or manual `new` calls.

## Dependency Direction

- Controllers and transport handlers depend on application providers, not persistence internals.
- Product providers may depend on ports or established data adapters; infrastructure must not own domain
  policy.
- Resolve circular dependencies by revisiting ownership, extracting a stable contract, or using events.
  Use `forwardRef()` only when a genuine bidirectional lifecycle remains and its cost is accepted.
- Avoid reaching into another module's internal provider through `ModuleRef` when a normal exported
  contract can express the dependency.

## Check

Compile or bootstrap a `TestingModule` that includes the affected modules. Verify tokens resolve, exports
are sufficient, scopes match the intended lifecycle, and removing an import would not be masked by an
unrelated global module.
