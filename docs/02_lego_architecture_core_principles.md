# 🧩 Core Principles of Lego Architecture (iOS Edition)

This project strictly adheres to the **Lego Architecture**, translating the highly modular approach into a **Native iOS XcodeGen Multi-Target** environment.

The goal of Lego Architecture is to break down a monolithic iOS app into isolated, self-contained, and highly reusable building blocks.

## 1. The Monorepo Structure

Instead of one giant target with endless folders, the codebase is logically divided into independent module boundaries.

### 🏢 `App` (The Baseplate)
The `App` module contains the application shell (e.g., `@main struct LegoStyleDemoApp: App`).
Think of this as the green baseplate you build Lego sets on. It contains almost **zero business logic**. Its sole responsibility is to:
1. Initialize the app environment.
2. Register global dependencies (e.g., via `@StateObject`).
3. Wire together routing (`NavigationStack`).
4. Assemble the various feature blocks into a unified UI.

### ⚙️ `Core` (The Technical Bricks)
The `Core` namespace houses Swift files that handle purely technical, non-UI infrastructure.
Examples: 
- `Network` (URLSession clients)
- `DesignSystem` (Typography, colors, common SwiftUI widgets)

### ✨ `Features` (The Lego Blocks)
This is where the magic happens. Every single feature of the app is an **isolated folder/target** inside the `Features` namespace.
Examples:
- `LegoList`
- `HarryPotter`

## 2. The Golden Rules of a Lego Block

A feature module (Lego block) must be completely self-contained. It should have its own:
- **UI / Presentation Layer**: SwiftUI screens specific to this feature.
- **State Management**: `ObservableObject` and `@Published`.
- **Data Layer**: Repositories and Data Sources.

### 🚫 Strict Isolation Boundaries
- **Rule 1**: A Lego block in `Features` **cannot** strongly depend on another Lego block in `Features` without a protocol boundary. 
- **Rule 2**: If two blocks need to communicate, they must do so via Interfaces, Shared State (via `Core`), or Routing managed by `App`.
- **Rule 3**: Lego blocks must never assume they are running inside a specific app. They should be agnostic, allowing them to be plugged into a different App Shell seamlessly.

## 3. Dependency Injection (Wiring the Blocks)
Lego blocks expose their dependencies, but they don't fulfill them globally. 
The App Shell (`App`) injects dependencies (like the network client) into the `Features` blocks at runtime using standard init injection or `@EnvironmentObject`.
