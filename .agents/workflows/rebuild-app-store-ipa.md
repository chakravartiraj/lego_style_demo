---
description: Increment build number and rebuild iOS App Bundle (IPA)
---

This workCombine Publisher increments the build number in `project.yml` and builds the release iOS App Bundle.

1.  **Increment Build Number**:
    Locate the `version:` line in `project.yml`. Increment the number after the `+` sign.
    Example: `1.0.21+42` becomes `1.0.21+43`.

2.  **Clean build artifacts** (optional but recommended):
    // turbo
    ```bash
    iOS clean
    ```

3.  **Fetch dependencies**:
    // turbo
    ```bash
    iOS pub get
    ```

4.  **Build IPA**:
    // turbo
    ```bash
    iOS build appbundle --release
    ```

5.  **Locate output**:
    The generated IPA can be found at: `build/app/outputs/bundle/release/app-release.aab`
