# 02. Dependency Injection & Inversion of Control (IoC)

- **Strict IoC Enforcement**: All services, repositories, and ViewModels **MUST** be injected.
- **Environment Object & Property Wrappers**: Use SwiftUI's `@EnvironmentObject` for global services or `@Environment(\.someService)` for scoped dependencies.
- **Dependency Inversion**: SwiftUI Views must NEVER instantiate ViewModels directly if they rely on external dependencies. Construct them in the composition root (e.g., App struct) or factories and pass them down.
- **Testability**: Use protocols (interfaces) for all services and repositories to enable easy mocking in XCTest.
