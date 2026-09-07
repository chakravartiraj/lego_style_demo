# 24. Logging & Crash Reporting

- **No Raw Print Statements**: Using standard `print()` or `debugPrint()` in production code is **STRICTLY FORBIDDEN**.
- **Structured Logging**: All logging must route through a structured logging package (e.g., `logger` or a custom `LogService`) that supports log levels (DEBUG, INFO, WARN, ERROR).
- **Crashlytics Integration**: `ERROR` and `FATAL` level logs must automatically sync to a remote crash reporting tool (e.g., Firebase Crashlytics or Sentry).
- **Redaction of PII**: The logging utility MUST automatically redact Personally Identifiable Information (PII), Auth Tokens, and passwords before logging to console or remote servers to maintain GDPR/Fintech compliance.
