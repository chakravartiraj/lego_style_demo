---
description: Increment build number and rebuild IPA (Ad-Hoc / Development)
---

# Rebuild IPA (Development/Ad-Hoc)

This workflow increments the build number in `project.yml` and builds the IPA via `xcodebuild`.

1.  **Increment Build Number**:
    Locate the `BUILD_VERSION` or `CURRENT_PROJECT_VERSION` in `project.yml` and increment it.

2.  **Clean build artifacts**:
    ```bash
    make clean-ios
    ```

3.  **Generate Project**:
    ```bash
    xcodegen generate
    ```

4.  **Archive Project**:
    ```bash
    xcodebuild archive -project LegoStyleDemo.xcodeproj -scheme LegoStyleDemo -configuration Release -archivePath build/LegoStyleDemo.xcarchive
    ```

5.  **Export IPA**:
    ```bash
    xcodebuild -exportArchive -archivePath build/LegoStyleDemo.xcarchive -exportOptionsPlist ExportOptions.plist -exportPath build/
    ```
    The generated IPA will be in the `build/` folder.
