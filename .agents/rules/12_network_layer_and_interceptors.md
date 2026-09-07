# 12. Network Layer & Interceptors

- **Centralized HTTP Client**: All network requests MUST route through a centralized, pre-configured HTTP client instance (e.g., a singleton `Retrofit` client). Do not instantiate bare `http.Client` randomly.
- **Interceptor Architecture**: Cross-cutting network concerns MUST be handled via Interceptors, not manually inside repository methods. This includes:
  - **Authentication**: Injecting the Bearer token into headers.
  - **Token Refresh**: Automatically catching 401 Unauthorized errors, refreshing the token, and retrying the failed request transparently.
  - **Logging**: Logging request payloads and response bodies (in non-production environments only).
- **Timeouts**: The network client MUST have strict global connection and receive timeouts configured to prevent the app from hanging indefinitely on poor connections.
- **No UI Coupling**: The network layer MUST NEVER attempt to trigger UI actions directly (e.g., showing a dialog on a 500 error). It must yield a mapped `Failure`, and the UI/ObservableObject is responsible for the presentation of that failure.
