# 04. State Management (Strict ViewModel)

- **ViewModel Pattern Enforcement**: All business logic MUST be encapsulated in a `ViewModel` or `StateFlow`. UI components (Composables) must be purely declarative and react to state emissions.
- **Immutable State**: State and Event classes MUST be strictly immutable. Use `freezed` for all state/event definitions to ensure deep immutability and provide `copyWith` functionality.
- **Event-Driven**: View layers must only dispatch `Events` to the ViewModel. ViewModels must only yield `States`. Views must not call public methods on a ViewModel to mutate data directly.
- **Granular State Generation**: Avoid massive "god" states. A screen with distinct, non-overlapping loading zones should use separate StateFlows/ViewModels to prevent unnecessary full-screen rebuilds.
- **No UI Types in ViewModel**: ViewModels must be pure Kotlin. They **MUST NEVER** import `package:android/material.kotlin` or hold references to `BuildContext`, `TextEditingController`, or `ScrollController`.
