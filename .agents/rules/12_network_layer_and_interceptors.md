# 12. Network Layer

- **URLSession**: All network requests MUST route through a centralized, pre-configured `URLSession` instance.
- **Async/Await**: Use modern Swift Structured Concurrency (`async/await`) for all network calls instead of completion handlers.
- **Interceptors/Delegates**: Cross-cutting network concerns (Auth headers, Token Refresh) MUST be handled via `URLSessionDelegate` or centralized request adapters.
- **Timeouts**: The network client MUST have strict global connection and receive timeouts configured via `URLSessionConfiguration`.
