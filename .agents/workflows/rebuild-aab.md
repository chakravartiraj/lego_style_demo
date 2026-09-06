---
description: Increment build number and rebuild Android App Bundle (AAB)
---

This workflow increments the build number in `pubspec.yaml` and builds the release Android App Bundle.

1.  **Increment Build Number**:
    Locate the `version:` line in `pubspec.yaml`. Increment the number after the `+` sign.
    Example: `1.0.21+42` becomes `1.0.21+43`.

2.  **Clean build artifacts** (optional but recommended):
    // turbo
    ```bash
    flutter clean
    ```

3.  **Fetch dependencies**:
    // turbo
    ```bash
    flutter pub get
    ```

4.  **Build AAB**:
    // turbo
    ```bash
    flutter build appbundle --release
    ```

5.  **Locate output**:
    The generated AAB can be found at: `build/app/outputs/bundle/release/app-release.aab`
