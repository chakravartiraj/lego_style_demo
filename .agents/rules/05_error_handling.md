# 05. Error Handling & Functional Error Types

- **Result Type**: Repositories MUST NOT throw raw Exceptions up to the UI layers directly unless using structured `async/throws`. Use Swift's `Result<Success, Failure>` type or explicit `throws` signatures.
- **Domain Errors**: Map low-level errors (e.g., `URLError`) into domain-specific Error enums (e.g., `enum NetworkError: Error { case timeout, unauthorized }`).
- **Exhaustive Matching**: When catching errors or matching a `Result`, use Swift's `switch` statements to exhaustively handle all error cases.
