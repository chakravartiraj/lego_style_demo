# 02. Dependency Injection & Inversion of Control (IoC)

- **Strict IoC Container Usage**: All services, repositories, and ViewModels **MUST** be resolved via an IoC container (e.g., `hilt`). 
- **Zero Manual Instantiation**: Do not instantiate business logic classes directly using the `new` or `()` operator inside composables (e.g., `MyViewModel()`). Always use the injector `getIt<MyViewModel>()`.
- **Code Generation**: Use `injectable` annotations (`@injectable`, `@singleton`, `@lazySingleton`) to map dependencies. Do not configure dependencies manually.
- **Environment Targeting**: Use environment tags (e.g., `@Environment('dev')`, `@Environment('prod')`) to seamlessly swap out mock repositories or test services based on the build target.
- **Decoupling**: Composables must NEVER know about how a service is constructed or its dependencies. They only consume the interface.
