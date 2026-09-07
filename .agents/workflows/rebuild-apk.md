---
description: Increment build number and rebuild APK
---

This workflow increments the build number in `build.gradle.kts` and builds the release APK.

1.  **Increment Build Number**:
    Locate the `version:` line in `build.gradle.kts`. Increment the number after the `+` sign.
    Example: `1.0.21+43` becomes `1.0.21+44`.

2.  **Clean build artifacts** (optional but recommended):
    // turbo
    ```bash
    android clean
    ```

3.  **Fetch dependencies**:
    // turbo
    ```bash
    android pub get
    ```

4.  **Build APK**:
    // turbo
    ```bash
    android build apk --release
    ```

5.  **Locate output**:
    The generated APK can be found at: `build/app/outputs/android-apk/app-release.apk`
