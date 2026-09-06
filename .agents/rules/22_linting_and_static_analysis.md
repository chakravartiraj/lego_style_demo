# 22. Code Formatting, Linting & Analysis

- **Strict Analysis Options**: The project MUST maintain a strict `analysis_options.yaml` file across all packages, enforcing standard `android_lints` and specific pedantic rules (e.g., `prefer_const_constructors`, `require_trailing_commas`, `avoid_print`).
- **Zero Warnings Policy**: Code with static analysis warnings or errors is considered broken and MUST NOT be committed.
- **Standard Formatting**: All Kotlin files MUST be formatted using `kotlin format` (80-character line limit) before committing. CI pipelines will fail if files are unformatted.
- **Type Safety**: Avoid using `dynamic` or `Object` types. Leverage Kotlin 3's robust type system, pattern matching, and sealed classes to ensure exhaustive type safety at compile time.
