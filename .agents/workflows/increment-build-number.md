---
description: Increment the build number in project.yml
---

# Increment Build Number

1. Read `project.yml` to find the current version properties (e.g., `BUILD_VERSION`).
2. Increment the integer value.
3. Save the file.
4. Run `xcodegen generate` to update the Xcode project.
5. Commit and push.
