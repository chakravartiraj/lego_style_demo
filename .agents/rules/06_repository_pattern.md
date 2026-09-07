# 06. Data Layer & Repository Pattern

- **Strict Repository Boundaries**: ViewModels/Publisheds MUST ONLY interact with `Repository` interfaces, never directly with APIs, Local Storage, or third-party SDKs.
- **Abstract Interfaces**: Define abstract repository interfaces in the Domain layer and implement them in the Data layer to adhere to the Dependency Inversion Principle.
- **Single Source of Truth**: Repositories are responsible for determining whether to fetch data from a local cache or a remote data source. The ObservableObject must be oblivious to data origins.
- **Data Transfer Objects (DTOs)**: API responses must be parsed into DTOs (e.g., `UserDto`). The repository MUST map these DTOs into pure Domain entities (e.g., `User`) before returning them to the ObservableObject. ViewModels must only work with pure Domain entities.
