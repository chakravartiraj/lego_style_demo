# 10. Routing & Navigation Architecture

- **Declarative Routing**: All navigation MUST be handled declaratively using `go_router`. Direct usage of imperative `Navigator.push()` or `Navigator.pop()` is forbidden outside of simple modal/dialog dismissals.
- **Deep-Link Ready**: Every screen in the app MUST have a defined route path to ensure it is immediately deep-linkable from push notifications or web links.
- **Type-Safe Routes**: Utilize `go_router_builder` to generate strongly-typed route classes. Never pass route arguments as raw untyped `Map` or `Object` payloads via `extra`.
- **Isolated Feature Routers**: In a monorepo, each feature package should define its own list of `GoRoute` objects. The main app package (`app/lego_navigation`) aggregates these feature routes into the root router to maintain decoupling.
- **Route Guards & Redirection**: All authentication and permission-based routing logic (e.g., kicking an unauthenticated user to the login screen) MUST be handled centrally via `redirect` callbacks in the router, not inside UI widget `initState`.
