# 21. Asset Management & Theming

- **Centralized Design System**: All raw assets (images, fonts, SVGs, Lottie files) MUST reside strictly in the `core/design_system` package.
- **Zero Asset Duplication**: Feature packages MUST NOT declare their own `assets/` folders. They must consume assets exported by the `design_system`.
- **Theme Definition**: Colors, Typography, and Component Styles MUST be defined centrally within a strict `ThemeData` object in the design system. 
- **Type-Safe Asset References**: Never hardcode asset paths like `'assets/images/logo.png'` in widgets. Use a generated or dedicated static class (e.g., `AppAssets.logo`) to ensure compile-time safety and prevent typos.
