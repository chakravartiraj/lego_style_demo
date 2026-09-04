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
*   **Creating New Features**: When adding a new feature, consider creating a new isolated package inside the `feature/` folder, and then integrating it through the `app/lego_app` or `app/lego_navigation` layers.
*   **Code Generation**: This project utilizes `freezed` for models and state. If you make changes to files with the `.freezed.dart` extension (or edit models that rely on it), you will need to run the build runner. Make sure to run it inside the specific package where you made the change:
    ```bash
    # Example: If you edited a model in the harry_potter feature
    cd feature/harry_potter
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
