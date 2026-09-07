---
description: Increment build number and rebuild App Store IPA
---

# Rebuild App Store IPA

This workflow increments the build number in `project.yml` and builds the App Store IPA.

1.  **Increment Build Number**:
    Locate the `BUILD_VERSION` or `CURRENT_PROJECT_VERSION` in `project.yml` and increment it.

2.  **Clean build artifacts**:
    ```bash
    make clean-ios
    ```

3.  **Archive Project**:
    ```bash
    xcodebuild archive -project LegoStyleDemo.xcodeproj -scheme LegoStyleDemo -configuration Release -archivePath build/LegoStyleDemo.xcarchive
    ```

4.  **Export for App Store**:
    Use an `ExportOptionsAppStore.plist` configured for App Store distribution.
    ```bash
    xcodebuild -exportArchive -archivePath build/LegoStyleDemo.xcarchive -exportOptionsPlist ExportOptionsAppStore.plist -exportPath build/AppStore/
    ```
