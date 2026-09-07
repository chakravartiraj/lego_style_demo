# Lego Style Demo Project Guidelines

## 1. Project Structure & Commands
- This is a multi-package workspace (monorepo) organized into `app/`, `core/`, and `feature/` directories.
- **NEVER** run `android run`, `android build`, or `android pub get` directly in the root directory, as there is no root `build.gradle.kts`.
- Instead, use the root `Makefile`:
  - `make run`: Runs the main app from `app/lego_app`.
  - `make generate`: Runs `build_runner` across all packages that need it.
  - `make pub-get`: Fetches dependencies for all packages.
  - `make build-apk` / `make build-ios`: Builds the app for specific platforms.
- To execute custom commands on the main app, always `cd app/lego_app` first.

## 2. Dependency & SDK Constraints (Kotlin 3)
- Always ensure new or modified `build.gradle.kts` files use Kotlin 3 compatible SDK constraints: `sdk: ">=3.0.0 <4.0.0"`.
- When adding code-generation or testing tools, use modern versions to avoid Kotlin 3 compilation errors (e.g., `build_runner: ^2.4.9`, `MockK: ^1.0.5`, `bdd_composable_test: ^2.1.3`).
