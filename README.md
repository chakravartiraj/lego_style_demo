# Lego Style Demo

Welcome to the **Lego Style Demo** project! This project follows a modular, multi-package architecture (often referred to as a "monorepo") to keep code separated by features and domains, much like building with Lego blocks.

## Project Structure

This repository is split into several local packages instead of a single massive Flutter app. You can find them under these main directories:

*   **`app/`**: Contains the main application and configuration packages.
    *   `lego_app/`: The primary entry point and main Flutter application. **This is where you run build commands.**
    *   `lego_configuration/`: App-level configurations.
    *   `lego_navigation/`: App-level routing and navigation logic.
*   **`core/`**: Reusable code that is not tied to a specific feature.
    *   `design_system/`: UI components, themes, and shared assets used across the app.
*   **`feature/`**: Individual, self-contained feature packages.
    *   `harry_potter/`: Logic, state, and UI related to the Harry Potter feature.
    *   `lego_list/`: Logic, state, and UI related to the Lego List feature.

## Getting Started

Because this is a multi-package project, you need to be aware of where you run your commands. The root folder does not contain a `pubspec.yaml` file.

### 1. Fetching Dependencies

To start working, you need to fetch the dependencies for all the packages in the repository.

You can do this by running `flutter pub get` in each of the package directories manually:
```bash
# Example
cd app/lego_app
flutter pub get
# Repeat for other packages like core/design_system, feature/harry_potter, etc.
```

*(Alternatively, you can run a one-liner from the root of the project in your terminal to fetch dependencies for all nested `pubspec.yaml` files)*:
```bash
find . -name "pubspec.yaml" -execdir flutter pub get \;
```

### 2. Building and Running the App

To run the app on a simulator or physical device, you must execute the commands from the main app package directory:

```bash
cd app/lego_app
flutter run
```

To build a release APK for Android:
```bash
cd app/lego_app
flutter build apk
```

## How to Code

*   **IDE Setup**: You should open the **root directory** (`lego_style_demo`) in your IDE (like VS Code or Android Studio). This allows you to navigate and edit code across all packages (`app`, `core`, and `feature`) seamlessly.
## Workflow: Integrating a New Feature

When you need to build a new feature, follow this standard workflow to keep the Lego architecture clean and modular:

1.  **Create a New Feature Package:**
    *   Navigate to the `feature/` directory and create a new Flutter package:
        ```bash
        cd feature
        flutter create --template=package your_new_feature
        ```
2.  **Configure `pubspec.yaml`:**
    *   Open your new feature's `pubspec.yaml` and set the Dart SDK constraint to ensure Dart 3 compatibility: `sdk: ">=3.0.0 <4.0.0"`.
    *   Add any required dependencies (like `flutter_bloc`, `freezed`, `injectable`). If your feature needs UI components, add the `design_system` package as a path dependency:
        ```yaml
        dependencies:
          design_system:
            path: ../../core/design_system
        ```
3.  **Develop in Isolation:**
    *   Build your UI, State (Bloc/Cubit), and Models entirely within this new package.
    *   Export the necessary screens and public APIs in your package's main `lib/your_new_feature.dart` file.
4.  **Integrate with the Main App:**
    *   Once the feature is ready, link it to the main application.
    *   Open `app/lego_app/pubspec.yaml` (and `app/lego_navigation/pubspec.yaml` if you need to add routes) and add your feature as a dependency:
        ```yaml
        dependencies:
          your_new_feature:
            path: ../../feature/your_new_feature
        ```
5.  **Fetch and Generate:**
    *   Return to the root directory and run the Makefile tasks to resolve everything:
        ```bash
        make pub-get
        make generate
        ```

## Code Generation

This project utilizes `freezed` and `injectable` for models, state, and dependency injection. 

Whenever you make changes to files that require generation (e.g., adding a new `.freezed.dart` or `@injectable`), simply run the generate task from the root of the project:
```bash
make generate
```
This will automatically find all packages that need code generation and run `dart run build_runner build --delete-conflicting-outputs` for you.
