# 07. Domain Driven Design (DDD) Boundaries

- **Self-Contained Features**: Each feature inside the `feature/` folder must be a self-contained domain. It should encapsulate its own UI, State, Domain, and Data logic.
- **No Cross-Feature Dependencies**: A feature package MUST NEVER depend directly on another feature package to prevent circular dependencies and tight coupling.
- **Shared Domain Models**: If two features need to share the same domain models or business logic, that logic must be extracted into the `core/` package or a separate shared domain package.
- **Strict Layer Separation within Features**: Inside a feature package, maintain strict folder boundaries: `lib/src/presentation` (UI/BLoC), `lib/src/domain` (Entities/Abstract Repositories), and `lib/src/data` (API/DTOs/Repository Impls). Data MUST NOT import Presentation. Domain MUST NOT import Data.
