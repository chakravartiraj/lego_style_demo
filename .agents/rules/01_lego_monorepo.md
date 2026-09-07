# Lego Style Demo Project Guidelines

## 1. Project Structure & Commands
- This is a multi-package workspace organized into `Sources/App/`, `Sources/Core/`, and `Sources/Features/` directories.
- **NEVER** modify `.pbxproj` files directly. This project uses `XcodeGen`.
- Use the root `Makefile`:
  - `make build-ios`: Builds the app for the iOS Simulator using xcodebuild.
  - `make run-ios`: Runs the main app on the iOS Simulator.
  - `make clean-ios`: Cleans the iOS build directory.
- For dependency management, use Swift Package Manager (SPM).

## 2. Dependency & SDK Constraints
- Always ensure new or modified `project.yml` files use iOS 17.0+ compatible SDK constraints.
- When adding external dependencies, use SPM.
