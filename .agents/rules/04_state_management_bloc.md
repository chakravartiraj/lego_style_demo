# 04. State Management (Strict BLoC)

- **BLoC Pattern Enforcement**: All business logic MUST be encapsulated in a `Bloc` or `Cubit`. UI components (Widgets) must be purely declarative and react to state emissions.
- **Immutable State**: State and Event classes MUST be strictly immutable. Use `freezed` for all state/event definitions to ensure deep immutability and provide `copyWith` functionality.
- **Event-Driven**: View layers must only dispatch `Events` to the BLoC. BLoCs must only yield `States`. Views must not call public methods on a BLoC to mutate data directly.
- **Granular State Generation**: Avoid massive "god" states. A screen with distinct, non-overlapping loading zones should use separate Cubits/BLoCs to prevent unnecessary full-screen rebuilds.
- **No UI Types in BLoC**: BLoCs must be pure Dart. They **MUST NEVER** import `package:flutter/material.dart` or hold references to `BuildContext`, `TextEditingController`, or `ScrollController`.
