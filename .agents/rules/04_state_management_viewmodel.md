# 04. State Management (Strict ObservableObject)

- **ObservableObject Pattern Enforcement**: All business logic MUST be encapsulated in a class conforming to `ObservableObject` or using the new `@Observable` macro in Swift 5.9+.
- **Reactive State**: Use `@Published` properties (or `@Observable` properties) to drive SwiftUI Views.
- **Event-Driven**: View layers must only call explicit intents on the ViewModel. ViewModels must mutate their internal state, and Views react automatically.
- **No UI Types in ViewModel**: ViewModels must be pure Swift. They **MUST NEVER** import `UIKit` or hold references to `UIViewController` or `UITextField`.
