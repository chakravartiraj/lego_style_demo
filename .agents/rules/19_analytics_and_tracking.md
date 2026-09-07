# 19. Analytics & Event Tracking

- **Abstract Analytics Layer**: UI SwiftUI Views and ViewModels MUST NOT directly call third-party analytics SDKs (e.g., `FirebaseAnalytics.instance.logEvent`).
- **Unified Tracking Interface**: All analytics events must route through an abstract `AnalyticsService` interface. This allows multiplexing events to different backends (Mixpanel, Firebase, Amplitude) without changing business logic.
- **Event Definition**: Analytics events MUST be strongly typed (e.g., via sealed classes or Enums) rather than using raw string keys to prevent typos and ensure centralized documentation.
- **Separation of Concerns**: Logging an event should ideally happen as a side-effect in the ObservableObject (e.g., yielding a state and then calling the analytics service), keeping the UI completely oblivious to tracking requirements.
