# 🚀 Day 1: Onboarding Quickstart

Welcome to the **Lego Style Monorepo (iOS SwiftUI Edition)**! This repository is built upon feature-first "Lego Architecture" principles, ported entirely to Native Swift, SwiftUI, and XcodeGen.

If you are a new developer joining the team, this guide will help you get the app running on your machine in minutes.

## 1. Prerequisites
Ensure you have the following installed:
- [Xcode 15+](https://developer.apple.com/xcode/) (which includes the iOS SDK and swift tools)
- Make (Standard on macOS)
- XcodeGen (`brew install xcodegen`)

## 2. Cloning the Repository
```bash
git clone https://github.com/chakravartiraj/lego_style_demo.git
cd lego_style_demo
git checkout ios_swiftui
```

## 3. The `make` Workflow
This repository heavily relies on `Makefile` for executing complex project generation tasks.
You **do not** need to manually modify `.pbxproj` files.

Just run the following command from the root to generate the Xcode project:
```bash
make build-ios
```

## 4. Running the App
The primary entry point for the application is located in `Sources/App`.
To run the app on your connected device or simulator from the terminal:
```bash
make run-ios
# Or open LegoStyleDemo.xcodeproj in Xcode and click Play.
```

## 5. Running the Pre-commit Checks Locally
Before submitting a Pull Request, verify that your code adheres to our strict architectural and linting standards.
Run the CI checks manually:
```bash
make test-ios
```

## 6. Tide-Specific Engineering Standards (E2E Flow)

While this repository is structurally based on pure Lego Architecture, it is also heavily augmented with internal engineering constraints:

### A. The PARSV Commit Standard
Every single commit in this repository **must** strictly adhere to the PARSV structure.
*   **P**roblem: What is the issue?
*   **A**ctions: What was done?
*   **R**oot-cause: Why was it needed?
*   **S**olution: How was it solved?
*   **V**erification: How was it tested?

### B. View & Modal Management
To prevent overlapping sheets in SwiftUI, you must adhere to a single-instance visibility gate. Always use a centralized `@StateObject` or `@Binding` boolean flag to drive `.sheet` and `.alert` modifiers.

### C. Accessibility (WCAG 2.2)
Tide features target global audiences. All interactive SwiftUI elements must have explicit `.accessibilityLabel()`, support 44pt logical pixel touch targets, and handle dynamic type scaling.

---
**What's Next?** 
Read [02_lego_architecture_core_principles.md](02_lego_architecture_core_principles.md) to understand how the Swift modules are structured.
