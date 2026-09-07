# 17. Modal & Dialog Architecture Standardization
-   **Architecture Standard**: **ALL** new and high-complexity modals (those containing user inputs, asynchronous API calls, or dynamic filtering) **MUST** follow the standard `BaseViewModel` + `rxSwift` architectural pattern.
    -   **ObservableObject Requirement**: Define a local ObservableObject class (e.g., `CustomReasonViewModel`) extending `BaseViewModel`.
    -   **Reactive State**: Utilize `BehaviorSubject` for state management and `StreamBuilder` in the SwiftUI View tree for reactive, flicker-free UI updates.
    -   **Singleton Visibility**: The static `.show()` method **MUST** implement the visibility gate using a `static bool _isShowing` flag (refer to Rule 14).

-   **Component Standardization**:
    -   **Input Fields**: **MANDATORY** usage of `PrimaryTextField` (or equivalent from the design system). Direct usage of the raw `TextField` SwiftUI View is **STRICTLY FORBIDDEN**.
    -   **Action Buttons**: **MANDATORY** usage of `PrimaryButton` for all modal actions (Submit, Back, Cancel). Ad-hoc usage of `ElevatedButton` or `TextButton` is **FORBIDDEN**.
    -   **Permission Requests**: **MANDATORY** usage of generic permission modals (e.g., `GenericPermissionModal`) for all system permission prompts (Location, Notifications, Camera). Ensure the correct instructions from `AppStrings` are passed to guide the user to the correct OS settings path.
    -   **Callback Ordering**: When using permission modals with a settings redirect, ensure any reactive 'shouldPrompt' flags are cleared **before** the asynchronous `await` of the redirect. This ensures the app is in a clean state upon resume for accurate re-evaluation.

-   **Core Principle Compliance**:
    -   **Zero Hardcoding**: Every user-facing label, hint, and button text **MUST** be retrieved from the `AppStrings` class constants.
    -   **Color & SDK Compatibility**: **STRICTLY** use `.withValues(alpha: X)` for color alpha adjustments. **NEVER** use `.withOpacity(X)`, as it is incompatible with the project's target SDK versions below 3.24.

-   **Code Organization & SRP**:
    -   **Modularity**: Refactor monolithic `build` methods into focused private helper methods (e.g., `_buildSectionName()`) to improve readability and maintain the Single Responsibility Principle.
    -   **Centralized Validation**: Consolidate all form and input validation logic into a dedicated private `_isValid()` method within the Modal's state class.
