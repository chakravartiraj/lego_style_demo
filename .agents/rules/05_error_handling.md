# 05. Error Handling & Functional Error Types

- **Functional Error Handling**: Repositories MUST NOT throw raw Exceptions up to the UI/BLoC layers. They must catch exceptions and return a functional result type (e.g., `Either<Failure, Success>` or `Result<Success, Failure>`).
- **Domain Failures**: Map low-level exceptions (e.g., `SocketException`, `HttpException`) into domain-specific `Failure` classes (e.g., `NetworkFailure`, `ServerFailure`, `AuthFailure`).
- **Exhaustive Matching**: When a BLoC receives an `Either` type, it MUST exhaustively map both the Left (Failure) and Right (Success) paths to emit appropriate states.
- **Generic Error Fallbacks**: Never present raw stack traces or unhandled error strings to the user. Always fallback to a localized generic error message (e.g., "Something went wrong. Please try again later.") if a specific domain error mapping is absent.
