# 18. Feature Flags & Remote Configuration

- **Zero Hardcoded Rollouts**: Features that are in active development or pose stability risks MUST be guarded behind a feature flag (e.g., Firebase Remote Config or LaunchDarkly).
- **Graceful Degradation**: If the feature flag service is unreachable, the app must default to a safe, stable state (usually `false` for new features).
- **Decoupled Evaluation**: SwiftUI Views MUST NOT query the remote config SDK directly. A dedicated `FeatureFlagService` must be injected, allowing local overrides and easy testing.
- **Cleanup**: Once a feature is 100% rolled out and stable, its feature flag and all dead code paths MUST be systematically removed from the codebase in the following sprint.
