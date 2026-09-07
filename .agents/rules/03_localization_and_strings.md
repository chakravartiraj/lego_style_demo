# 03. Localization & String Management

- **Zero Hardcoding Policy**: Hardcoded user-facing strings (e.g., `Text('Hello World')`) are **STRICTLY FORBIDDEN** across the entire application.
- **Centralized Dictionary**: All strings must be extracted into ARB (Application Resource Bundle) files or a centralized localized strings class (e.g., generated via `intl`).
- **Semantic Keys**: Use descriptive, context-based semantic keys (e.g., `login_screen_submit_button`) rather than literal string keys (`submit`).
- **Dynamic Insertion**: Use string interpolation placeholders for dynamic data (e.g., `"Welcome {name}"`) rather than manual string concatenation in the UI.
- **Plurals and Genders**: Utilize `intl` packages for handling plurals and genders gracefully without manual if/else conditionals in composables.
