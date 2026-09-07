# 03. Localization & String Management

- **Zero Hardcoding Policy**: Hardcoded user-facing strings (e.g., `Text("Hello World")`) are **STRICTLY FORBIDDEN**.
- **String Catalogs**: All strings must be extracted into modern Xcode String Catalogs (`.xcstrings`) or `Localizable.strings` files.
- **Semantic Keys**: Use descriptive, context-based semantic keys (e.g., `"login_screen_submit_button"`) rather than literal string keys.
- **Plurals**: Utilize String Catalogs for handling plurals gracefully without manual conditionals in code.
