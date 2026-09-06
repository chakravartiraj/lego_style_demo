# 🚀 Day 1: Onboarding Quickstart

Welcome to the **Lego Style Monorepo (Android Compose Edition)**! This repository is built upon feature-first "Lego Architecture" principles, ported entirely to Native Kotlin Jetpack Compose and Gradle.

If you are a new developer joining the team, this guide will help you get the app running on your machine in minutes.

## 1. Prerequisites
Ensure you have the following installed:
- [Android Studio](https://developer.android.com/studio) (which includes the Android SDK and bundled JDK)
- Kotlin 1.9.22 / AGP 8.3.0 (Configured automatically via Gradle)
- Make (Standard on macOS/Linux)

## 2. Cloning the Repository
```bash
git clone https://github.com/chakravartiraj/lego_style_demo.git
cd lego_style_demo
git checkout android_compose
```

## 3. The `make` Workflow
This repository heavily relies on `Makefile` for executing complex monorepo tasks.
You **do not** need to manually click through Android Studio to run typical CI checks.

Just run the following command from the root to sync all Gradle dependencies across the entire monorepo:
```bash
make sync
```

## 4. Running the App
The primary entry point for the application is located in the `:app` module.
To run the app on your connected device or emulator from the terminal:
```bash
make build
# Or launch the ':app' configuration directly within Android Studio
```

## 5. Running the Pre-commit Checks Locally
Before submitting a Pull Request, verify that your code adheres to our strict architectural and linting standards.
Run the CI checks manually:
```bash
make lint
make test
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
To prevent overlapping popups in Compose, you must adhere to a single-instance visibility gate. Always use a centralized StateFlow or a `MutableState<Boolean>` flag in your ViewModel/DialogManager, resetting it to `false` automatically when dismissed.

### C. Accessibility (WCAG 2.2)
Tide features target global audiences. All interactive Compose elements must have explicit `Modifier.semantics`, support 48dp logical pixel touch targets, and handle explicit `FocusRequester` navigation for desktop/keyboard traversal.

---
**What's Next?** 
Read [02_lego_architecture_core_principles.md](02_lego_architecture_core_principles.md) to understand how the Gradle modules are structured.
