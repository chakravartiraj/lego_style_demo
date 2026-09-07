# 10. Routing & Navigation Architecture

- **Declarative Routing**: All navigation MUST be handled declaratively using SwiftUI's `NavigationStack`.
- **Value-Based Navigation**: Use `NavigationLink(value:)` and `.navigationDestination(for:)` to push routes based on strongly-typed Hashable data rather than strings.
- **Deep-Link Ready**: Every screen should ideally map to a deep link URL using `.onOpenURL` to parse deep links and inject paths into the `NavigationPath`.
- **Isolated Feature Routers**: Each feature package should handle its own internal routes, while the root `App` orchestrates global route state.
