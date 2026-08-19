# Persistence

Apply the backend [Persistence and Migrations](../../backend-engineering/references/persistence-and-migrations.md)
rules first.

## Preserve the Existing Boundary

- Keep Prisma, TypeORM, MikroORM, Mongoose, raw SQL, or another installed data layer unless the user asks
  for a migration.
- Follow the project's established location for queries. Nest does not require a repository wrapper;
  introduce one only when it protects a real domain, test, or provider boundary.
- Inject the existing database client, repository, model, or transaction abstraction through Nest's DI
  container.
- Do not return persistence entities directly when they expose internal fields or couple a public contract
  to storage shape.

## Queries and Transactions

- Select bounded data and the fields the operation needs. Inspect relations and generated queries for
  N+1 access.
- Put the complete business invariant inside one transaction when atomicity is required.
- Pass transaction context through the established abstraction; do not silently open independent writes
  inside a transactional workflow.
- Keep network calls outside the transaction unless an existing coordination design explicitly requires
  them.
- Back uniqueness and other enforceable invariants with database constraints, then map expected conflicts
  to stable domain or transport errors.

## Schema and Generated Code

- Change the ORM schema or migration source, then run the repository's generate and migration commands.
- Never edit generated clients or an applied migration.
- Update affected DTOs, mappings, fixtures, seeds, and consumers after schema generation.

## Check

Test the affected providers against a representative database when ORM mocks would hide query,
constraint, mapping, or transaction behavior. Validate migration upgrade and mixed-version compatibility.
