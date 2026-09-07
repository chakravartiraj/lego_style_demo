# 27. Accessibility & WCAG 2.2 Standards Integration

- **Systematic Accessibility Modifiers**:
  - **MANDATORY** usage of SwiftUI accessibility modifiers: `.accessibilityLabel()`, `.accessibilityValue()`, and `.accessibilityHint()` for all interactive UI elements.
- **Combine & Exclude**: Use `.accessibilityElement(children: .combine)` to group complex composables logically for VoiceOver. Use `.accessibilityHidden(true)` to hide purely decorative icons.
- **Dynamic Type Support**: The UI **MUST** gracefully handle system-level text scaling. Do not hardcode frame heights on Text views.
- **Contrast Ratios**: All text and essential iconography MUST meet WCAG AA contrast ratio requirements.
