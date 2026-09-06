# 🚀 Day 1: Onboarding Quickstart

Welcome to the **Lego Style Monorepo**! This repository is built upon the feature-first "Lego Architecture" principles popularized by Anna and Oleksandr Leushchenko at Flutter Vikings.

If you are a new developer joining the team, this guide will help you get the app running on your machine in minutes.

## 1. Prerequisites
Ensure you have the following installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Check `environment.sdk` in `pubspec.yaml` for the exact version)
- Make (Standard on macOS/Linux)

## 2. Cloning the Repository
```bash
git clone https://github.com/chakravartiraj/lego_style_demo.git
cd lego_style_demo
```

## 3. The `make` Workflow
This repository heavily relies on `Makefile` for executing complex monorepo tasks.
You **do not** need to run `flutter pub get` manually in every directory!

Just run the following command from the root to fetch all dependencies across the entire monorepo:
```bash
make pub-get
```

## 4. Running the App
The primary entry point for the application is located in the `app/lego_app` package.
To run the app on your connected device or simulator:
```bash
cd app/lego_app
flutter run
```
*(Alternatively, you can use `make run-ios` or `make run-android` from the root if configured).*

## 5. Running the Pre-commit Checks Locally
Before submitting a Pull Request, verify that your code adheres to our strict architectural and linting standards.
Run the CI checks manually:
```bash
make lint
make test-report
```

## 6. Tide-Specific Engineering Standards (E2E Flow)

While this repository is structurally based on pure Lego Architecture, it is also heavily augmented with **Tide-specific internal engineering constraints** to ensure production-grade E2E development:

### A. The PARSV Commit Standard
Every single commit in this repository **must** strictly adhere to the PARSV structure. Commits failing this standard will be rejected.
*   **P**roblem: What is the issue?
*   **A**ctions: What was done?
*   **R**oot-cause: Why was it needed?
*   **S**olution: How was it solved?
*   **V**erification: How was it tested?

### B. Dialog & Modal Management
To prevent overlapping popups, you must adhere to the single-instance visibility gate. Always use a `static bool _isShowing` flag in your dialog managers, resetting it to `false` automatically when dismissed.

### C. Accessibility (WCAG 2.2)
Tide features target global audiences. All interactive widgets must have explicit `Semantics`, support 48x48 logical pixel touch targets (mobile), and have explicit `FocusNode` handling for desktop keyboard traversal.

---
**What's Next?** 
Read [02_lego_architecture_core_principles.md](02_lego_architecture_core_principles.md) to understand how the codebase is structured.
