# Lego Style Demo (Android Compose Port)

Welcome to the **Lego Style Demo** project! This branch exclusively follows a modular, multi-package architecture (often referred to as a "Multi-Module Gradle Architecture") to keep code separated by features and domains, much like building with Lego blocks. It is written completely natively in Kotlin utilizing Jetpack Compose for the UI layer.

## Project Structure

This repository is split into several local Gradle subprojects instead of a single massive Android app module. You can find them defined in `settings.gradle.kts` under these main directories:

*   **`:app`**: Contains the main application entry point, global dependency injection (Hilt) configuration, and top-level Compose Navigation graphs. **This is the module you deploy to a device.**
*   **`:core`**: Reusable code that is not tied to a specific feature.
    *   `design_system`: Android Library module containing the Jetpack Compose `MaterialTheme` components, color schemes (like our Sleek Dark Mode), and shared assets used across the app.
*   **`:feature`**: Individual, self-contained feature packages.
    *   `harry_potter`: Android Library module containing the logic, state (ViewModels), and Compose UI related to the Harry Potter feature.
    *   `lego_list`: Android Library module containing the logic, state (ViewModels), and Compose UI related to the Lego List feature.

## Getting Started

Because this is a multi-module project, Gradle manages all the dependencies for you from the root `settings.gradle.kts` and `build.gradle.kts` files.

### 1. IDE Setup
1. Open **Android Studio**.
2. Select **File > Open...** and select the root directory of this repository (the folder containing `settings.gradle.kts`).
3. Allow Gradle to perform its initial sync. It will automatically download Kotlin, Jetpack Compose, and all necessary dependencies.

### 2. Building and Running the App

To run the app on an Android Emulator or physical device:
- Use the run configuration dropdown in Android Studio toolbar, select **app**, and click the Run (Play) button.

Alternatively, you can run Gradle commands from the terminal:
```bash
# Build the debug APK
./gradlew :app:assembleDebug

# Run static analysis and tests
./gradlew lint testDebugUnitTest
```

## Workflow: Integrating a New Feature

When you need to build a new feature, follow this standard workflow to keep the Lego architecture clean and modular:

1.  **Create a New Feature Module:**
    *   In Android Studio, right click the project root and select **New > Module**.
    *   Select **Android Library** and name it something like `:feature:your_new_feature`.
2.  **Configure `build.gradle.kts`:**
    *   Open your new feature's `build.gradle.kts` file.
    *   Enable Jetpack Compose and add any required dependencies (like Hilt for injection or ViewModel libraries).
    *   If your feature needs UI components, add the `:core:design_system` module as a project dependency:
        ```kotlin
        dependencies {
            implementation(project(":core:design_system"))
            // Other dependencies...
        }
        ```
3.  **Develop in Isolation:**
    *   Build your UI (using `@Composable` functions), State (ViewModels), and Repository interfaces entirely within this new module.
4.  **Integrate with the Main App:**
    *   Once the feature is ready, link it to the main application shell.
    *   Open `app/build.gradle.kts` and add your feature as a dependency:
        ```kotlin
        dependencies {
            implementation(project(":feature:your_new_feature"))
        }
        ```
5.  **Sync Gradle:**
    *   Click "Sync Now" in Android Studio to resolve the new module graph.

## Code Generation & DI

This native port utilizes **Hilt (Dagger)** for Dependency Injection. Unlike Flutter where manual commands like `make generate` were required, Android Studio and Gradle seamlessly run code generation via KSP (Kotlin Symbol Processing) every time you build the project. No manual terminal scripts are required!
