# 02. Dependency Injection & Inversion of Control (IoC)

- **Strict IoC Container Usage**: All services, repositories, and BLoCs **MUST** be resolved via an IoC container (e.g., `get_it`). 
- **Zero Manual Instantiation**: Do not instantiate business logic classes directly using the `new` or `()` operator inside widgets (e.g., `MyBloc()`). Always use the injector `getIt<MyBloc>()`.
- **Code Generation**: Use `injectable` annotations (`@injectable`, `@singleton`, `@lazySingleton`) to map dependencies. Do not configure dependencies manually.
- **Environment Targeting**: Use environment tags (e.g., `@Environment('dev')`, `@Environment('prod')`) to seamlessly swap out mock repositories or test services based on the build target.
- **Decoupling**: Widgets must NEVER know about how a service is constructed or its dependencies. They only consume the interface.
