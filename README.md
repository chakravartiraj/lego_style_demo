# Lego Style Demo (Native iOS SwiftUI Edition)

Welcome to the **Lego Style Demo** project! This branch exclusively follows a modular, feature-based architecture (often referred to as "Lego Architecture") to keep code separated by features and domains, much like building with Lego blocks. It is written completely natively in Swift utilizing SwiftUI for the UI layer and XcodeGen for project generation.

## Project Structure

This repository is split into distinct source directories instead of a single massive Xcode group. You can find them defined in `project.yml` under these main directories:

*   **`Sources/App`**: Contains the main application entry point (`@main App`), global dependency injection (@StateObject/Environment) configuration, and top-level NavigationStack routing. **This is the main target you deploy to a device.**
*   **`Sources/Core`**: Reusable code that is not tied to a specific feature.
    *   `DesignSystem`: Contains the SwiftUI components, color schemes (like our Sleek Dark Mode), and shared assets used across the app.
    *   `Network`: URLSession clients, API definitions, and models.
*   **`Sources/Features`**: Individual, self-contained feature packages.
    *   `HarryPotter`: Module containing the logic, state (ObservableObjects), and SwiftUI UI related to the Harry Potter feature.
    *   `LegoList`: Module containing the logic, state (ObservableObjects), and SwiftUI UI related to the Lego List feature.

## Getting Started

Because this project dynamically generates its `.xcodeproj` file to prevent merge conflicts, you will use `XcodeGen` and our root `Makefile` to get started.

### 1. Environment Setup
Ensure you have Xcode 15+ and `xcodegen` installed.
```bash
brew install xcodegen
```

### 2. Building and Running the App
To run the app on an iOS Simulator, simply use the `make` commands from your terminal:

```bash
# Generate the Xcode project and build for the Simulator
make build-ios

# Boot the simulator and launch the app
make run-ios
```

Alternatively, after running `make build-ios`, you can open the generated `LegoStyleDemo.xcodeproj` in Xcode and click the Play button.

### 3. CI and Testing
To run static analysis and tests locally before opening a PR:
```bash
make test-ios
```

## Workflow: Integrating a New Feature

When you need to build a new feature, follow this standard workflow to keep the Lego architecture clean and modular:

1.  **Create a New Feature Folder:**
    *   Navigate to `Sources/Features/` and create a new directory (e.g., `NewFeature`).
2.  **XcodeGen Auto-Linking:**
    *   Because our `project.yml` is configured to glob the `Sources/` directory, simply adding files to this folder will automatically include them in the next Xcode build.
3.  **Develop in Isolation:**
    *   Build your UI (using `View`), State (`ObservableObject`), and Repository interfaces entirely within this new module.
4.  **Integrate with the Main App:**
    *   Once the feature is ready, link it to the main application shell inside `Sources/App`.
    *   Add it to your `NavigationStack` routing destination.
5.  **Regenerate Project:**
    *   Run `make build-ios` to update the Xcode indices.

## Dependency Management

This native port utilizes **Swift Package Manager (SPM)** for external dependencies. Any external libraries should be added to the `dependencies:` block inside the `project.yml` file, and XcodeGen will automatically resolve them during project generation.
