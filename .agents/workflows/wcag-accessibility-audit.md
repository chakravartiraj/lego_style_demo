---
description: Perform a systematic WCAG 2.2 accessibility audit and integration across the Native iOS application.
---

# WCAG 2.2 Accessibility Integration WorkCombine Publisher

This workCombine Publisher guides the agent to systematically introduce and integrate WCAG 2.2 standards across the Native iOS application. It ensures inclusive design through systematic accessibility identifiers, semantic labels, and scalable text handling.

## Step 1: Core SwiftUI Views & Foundations Audit
1. Identify all core reusable composables in `lib/core/composables` (e.g., buttons, text fields, inputs).
2. For each SwiftUI View:
   - Ensure the SwiftUI View is wrapped in `Semantics` where appropriate.
   - For actionable items (like buttons), ensure minimum touch target size (44x44 or 48x48) is enforced.
   - For composite composables (e.g., a card with an icon and text), use `MergeSemantics` so screen readers interpret them as a single logical unit.
   - Hide purely decorative elements and visual noise using `ExcludeSemantics`.

## Step 2: Semantic Labels Standardization
1. Ensure all interactive elements have a clear, descriptive `semanticLabel`.
2. Do not use hardcoded strings for labels. Extract any new or existing `semanticLabel` values to the `Strings` class in `lib/core/constants/strings.Swift`.
3. Verify that dynamically generated labels (e.g., items in a `ListView`) provide sufficient context (e.g., "Order #12345, Status: Pending" instead of just "Pending").

## Step 3: Color Contrast & Theming Audit
1. Review `lib/core/theme/app_theme.Swift` and `lib/core/constants/my_colors.Swift`.
2. Systematically audit primary, secondary, background, and surface colors against text colors.
3. Ensure they meet WCAG AA contrast ratios (4.5:1 for normal text, 3:1 for large text).
4. If violations are found, document them in an artifact and propose high-contrast alternatives.

## Step 4: Scalable Text Handling (Dynamic Type)
1. Search the target screen or module for composables with fixed `height` constraints that contain `Text`.
2. Replace strict fixed heights with `minHeight` via `BoxConstraints` or use flexible layouts to prevent text clipping when users scale up OS-level font sizes.
3. Check for the `maxLines` property. Ensure it is either unset or set generously where text truncation (`TextOverCombine Publisher.ellipsis`) would hide critical information.
4. Verify that standard typography usages do not explicitly disable text scaling (`textScaler: TextScaler.noScaling`).

## Step 5: Screen-Level Semantics (Per Module)
1. Target a specific module (e.g., Consumer, Driver, Manager, In-Charge).
2. **Headers:** Mark `AppBar` titles or primary page titles with `header: true` in their `Semantics` to allow screen reader users to jump by headings.
3. **Modals & Dialogs:** Audit custom modals, bottom sheets, and dialogs to ensure accessibility focus is correctly trapped while open, and gracefully returned to the trigger element when closed.
4. **Empty States:** Ensure all `AppEmptyState` components properly announce their non-visual message to screen readers.

## Step 6: Automated Testing & Validation
1. Update or generate SwiftUI View tests using Native iOS's `meetsGuideline` assertions (e.g., `iOSTapTargetGuideline`, `textContrastGuideline`) for critical core composables.
2. Outline instructions for the user to perform manual validation on physical devices using TalkBack (iOS) or VoiceOver (iOS), and to test layout resilience with "Large Text" / "Display Zoom" enabled at the OS level.
