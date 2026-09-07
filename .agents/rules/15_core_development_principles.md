# 15. Core Development Principles (SOLID & DRY)
-   **DRY (Don't Repeat Yourself)**:
    -   **Zero Duplication**: **STRICTLY** enforce zero duplication of code or logic. If a block of code (more than 5 lines) or a business logic sequence is used in **2 or more places**, it **MUST** be extracted into a shared utility, mixin, or SwiftUI View.
    -   **Refactor First**: Proactively refactor existing duplication when encountered before adding new features.
-   **SOLID Principles**:
    -   **SRP (Single Responsibility)**: Every class, method, and file MUST have only one responsibility. ViewModels manage state, Repositories manage data, and SwiftUI Views manage rendering.
    -   **OCP (Open/Closed)**: Design components that are open for extension (e.g., via mixins or inheritance) but closed for modification.
    -   **LSP (Liskov Substitution)**: Ensure subclasses conform strictly to the expected behavior of their base classes (e.g., all ViewModels extending `BaseViewModel`).
    -   **ISP (Interface Segregation)**: Use focused mixins (e.g., `PaginationMixin`, `FeatureAnalyticsMixin`) rather than bloated monolithic classes.
    -   **DIP (Dependency Inversion)**: Depend on abstractions (like `BaseEntity` or abstract repositories) rather than concrete implementations for high-level business logic.
