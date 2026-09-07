---
trigger: always_on
---
# 14. Dialog & Modal Management
-   **Single Instance Enforcement**: **STRICTLY** ensure that only one instance of a dialog, modal, bottomsheet, or material banner can be shown at any given time.
-   **Implementation**: All such components **MUST** be implemented with a singleton-like visibility gate using a `static bool _isShowing` flag.
-   **Safety Gate**: The `show()` method (or equivalent) MUST check this flag before opening the component and return immediately if it is already visible.
-   **Resetting State**: The flag MUST be reset to `false` when the component is dismissed (e.g., using `.then((_) => _isShowing = false)` on the Future returned by the show method).
