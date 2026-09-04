---
description: Increment build number and rebuild APK
---

This workflow increments the build number in `pubspec.yaml` and builds the release APK.

1.  **Increment Build Number**:
    Locate the `version:` line in `pubspec.yaml`. Increment the number after the `+` sign.
    Example: `1.0.21+43` becomes `1.0.21+44`.

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

4.  **Build APK**:
    // turbo
    ```bash
    flutter build apk --release
    ```

5.  **Locate output**:
    The generated APK can be found at: `build/app/outputs/flutter-apk/app-release.apk`
