# 🧩 Core Principles of Lego Architecture (Android Edition)

This project strictly adheres to the **Lego Architecture**, translating the highly modular approach originally proposed for Flutter into a **Native Android Gradle Multi-Module** environment.

The goal of Lego Architecture is to break down a monolithic Android app into isolated, self-contained, and highly reusable building blocks (Gradle modules).

## 1. The Monorepo Structure

Instead of one giant `app/` module with endless packages, the codebase is divided into independent Gradle modules.

### 🏢 `:app` (The Baseplate)
The `:app` module contains the application shell (e.g., `MainActivity`, `Application` class).
Think of this as the green baseplate you build Lego sets on. It contains almost **zero business logic**. Its sole responsibility is to:
1. Initialize the app environment (e.g., `@HiltAndroidApp`).
2. Register dependencies (Hilt Modules/Components).
3. Wire together routing (Jetpack Navigation / Compose Navigation).
4. Assemble the various feature blocks into a unified UI.

### ⚙️ `:core` (The Technical Bricks)
The `:core` namespace houses Android libraries that handle purely technical, non-UI infrastructure.
Examples: 
- `:core:testing` (Sociable testing utilities, MockWebServer wrappers)
- `:core:network` (Retrofit/OkHttp clients)
- `:core:design_system` (Material 3 Typography, colors, common Compose widgets)

### ✨ `:feature` (The Lego Blocks)
This is where the magic happens. Every single feature of the app is an **isolated Android Library module** inside the `:feature` namespace.
Examples:
- `:feature:lego_list`
- `:feature:harry_potter`

## 2. The Golden Rules of a Lego Block

A feature module (Lego block) must be completely self-contained. It should have its own:
- **UI / Presentation Layer**: Jetpack Compose screens specific to this feature.
- **State Management**: Android `ViewModel` and `StateFlow`.
- **Data Layer**: Repositories and Data Sources.

### 🚫 Strict Isolation Boundaries
- **Rule 1**: A Lego block in `:feature` **cannot** depend on another Lego block in `:feature`. 
- **Rule 2**: If two blocks need to communicate, they must do so via Interfaces, Shared State (via `:core`), or Deep Links/Routing managed by `:app`.
- **Rule 3**: Lego blocks must never assume they are running inside a specific app. They should be agnostic, allowing them to be plugged into a different App Shell seamlessly.

## 3. Dependency Injection (Wiring the Blocks)
Lego blocks expose their dependencies, but they don't fulfill them globally. 
The App Shell (`:app`) uses a Service Locator/DI Framework (like **Hilt/Dagger**) to inject the `:core:network` dependencies into the `:feature` blocks at runtime using `@Inject` and `@AndroidEntryPoint`.
