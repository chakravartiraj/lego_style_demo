# 04. State Management (Strict ObservableObject)

- **ObservableObject Pattern Enforcement**: All business logic MUST be encapsulated in a `ObservableObject` or `Published`. UI components (SwiftUI Views) must be purely declarative and react to state emissions.
- **Immutable State**: State and Event classes MUST be strictly immutable. Use `freezed` for all state/event definitions to ensure deep immutability and provide `copyWith` functionality.
- **Event-Driven**: View layers must only dispatch `Events` to the ObservableObject. ViewModels must only yield `States`. Views must not call public methods on a ObservableObject to mutate data directly.
- **Granular State Generation**: Avoid massive "god" states. A screen with distinct, non-overlapping loading zones should use separate Publisheds/ViewModels to prevent unnecessary full-screen rebuilds.
- **No UI Types in ObservableObject**: ViewModels must be pure Swift. They **MUST NEVER** import `package:iOS/material.Swift` or hold references to `BuildContext`, `TextEditingController`, or `ScrollController`.
