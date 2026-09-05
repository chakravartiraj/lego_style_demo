# 🧩 Core Principles of Lego Architecture

This project strictly adheres to the **Lego Architecture** for Flutter, a highly modular approach proposed by Anna and Oleksandr Leushchenko. 

The goal of Lego Architecture is to break down a monolithic Flutter app into isolated, self-contained, and highly reusable building blocks.

## 1. The Monorepo Structure

Instead of one giant `lib/` folder, the codebase is divided into independent packages.

### 🏢 `app/` (The Baseplate)
The `app/` directory contains the application shell (e.g., `lego_app`).
Think of this as the green baseplate you build Lego sets on. It contains almost **zero business logic**. Its sole responsibility is to:
1. Initialize the app environment.
2. Register dependencies (`GetIt`).
3. Wire together routing (`GoRouter`).
4. Assemble the various feature blocks into a unified UI.

### ⚙️ `core/` (The Technical Bricks)
The `core/` directory houses packages that handle purely technical, non-UI infrastructure.
Examples: 
- `core/testing` (Sociable testing utilities)
- `core/network` (Dio wrappers)
- `core/design_system` (Typography, colors, common widgets)

### ✨ `feature/` (The Lego Blocks)
This is where the magic happens. Every single feature of the app is an **isolated package** inside `feature/`.
Examples:
- `feature/lego_list`
- `feature/harry_potter`

## 2. The Golden Rules of a Lego Block

A feature package (Lego block) must be completely self-contained. It should have its own:
- **UI / Presentation Layer**: Widgets and pages specific to this feature.
- **State Management**: BLoCs or Cubits.
- **Data Layer**: Repositories and Data Sources.

### 🚫 Strict Isolation Boundaries
- **Rule 1**: A Lego block in `feature/` **cannot** depend on another Lego block in `feature/`. 
- **Rule 2**: If two blocks need to communicate, they must do so via Interfaces, Shared State (via `core/`), or Deep Links/Routing.
- **Rule 3**: Lego blocks must never assume they are running inside a specific app. They should be agnostic, allowing them to be plugged into a different App Shell seamlessly.

## 3. Dependency Injection (Wiring the Blocks)
Lego blocks expose their dependencies, but they don't fulfill them globally. 
The App Shell (`app/lego_app`) uses a Service Locator (like `get_it` and `injectable`) to inject the `core/network` dependencies into the `feature/` blocks at runtime.
