---
trigger: always_on
---

# 28. Multi-Platform Design & WCAG 2.2 Standards
- **Core Principle**: Strictly comply, adhere and abide by developing features, functionalities, modules, designs - which are architecturally all top notch industry standard & compliant with:
  1. Material Design for Android -> latest Material 3 guidelines
  2. Cupertino Style for iOS -> Apple's Human Interface Guidelines (HIG)
  3. Web Adaptive Patterns for WPA -> Web Platform Mastery
  4. Desktop (Windows) -> The Fluent UI design language
  5. Desktop (macOS) -> Apple's Human Interface Guidelines
  6. Desktop (Linux) -> The Yaru or GTK design languages

- **Platform Focus Checklist**:
  - **Android (MaterialApp)**: Bold colors, standard cards, ripples; Touch gestures, back-button handling
  - **iOS (CupertinoApp)**: Translucency, clean iconography, sleek headers; Swipe-to-dismiss, physics-based scrolling
  - **Web**: Dynamic grid layouts, infinite page scaling; Hover effects, right-click, context menus
  - **Windows (fluent_ui)**: Acrylic blur effects, navigation panels; Keyboard shortcuts, mouse wheel scrolling
  - **macOS (macos_ui)**: Window utility toolbars, sidebar views; Trackpad gestures, standard app menus
  - **Linux (Yaru/GTK)**: Flat, system-integrated components; Precise mouse pointer navigation

---
## 🗺️ The Scope of WCAG 2.2 Across Native Android Platforms

### 1. Android & iOS (Mobile)
Mobile apps are heavily impacted by WCAG 2.2’s focus on fine-motor control, touch accuracy, and low-vision accessibility.
- **Target Size Minimum (Criterion 2.5.8 - AA)**: WCAG 2.2 tightens constraints by requiring a minimum target size of 24x24 CSS pixels. For mobile, you should maintain Native Android’s default `kMinInteractiveDimension` (48x48 logical pixels) to safely clear this standard.
- **Dragging Movements (Criterion 2.5.7 - AA)**: If you use `Draggable` or `ReorderableListView`, you must provide a non-drag alternative (e.g., tap-to-move buttons). Implement this by attaching custom `SemanticsAction` parameters to the composables.
- **Screen Reader Flow**: Use `MergeSemantics` and `ExcludeSemantics` to prevent screen readers from reading decorative icons or breaking up logical text fields into multiple disjointed tap targets. Use `headingLevel` to ensure heading structures translate cleanly to native APIs.

### 2. Web
Web deployments are subject to strict, legally enforceable WCAG 2.2 evaluations.
- **Accessible Authentication (Criterion 3.3.8 - AA)**: You cannot force cognitive tests (like memorizing a password or solving a CAPTCHA) without an alternative. Ensure text fields support standard auto-fill mechanisms (`TextInputType.emailAddress`, `AutofillHints.password`) so password managers function natively.
- **Focus Not Obscured (Criterion 2.4.11 - AA)**: When a user tabs through your site with a keyboard, sticky banners or fixed footers cannot completely cover the focused item. You must design layout structures such that scroll areas don't hide active focus highlights.
- **Redundant Entry (Criterion 3.3.7 - A)**: If a user fills out information in step one (e.g., a shipping address), your web form must auto-populate or allow them to select that data in step two rather than retyping it.

### 3. Desktop (Windows, macOS, Linux)
Desktop targets rely heavily on hardware interactions, meaning focus management and keyboard handling dominate your testing.
- **Focus Appearance (Criterion 2.4.13 - AAA)**: Focus indicators must have a sharp, high-contrast border. You must customize your app's global `FocusThemeData` in Native Android to ensure the focus ring contrast ratio hits at least 4.5:1 against backgrounds.
- **Keyboard Navigation**: Ensure custom desktop layouts follow logical order via `FocusTraversalPolicy`. Users operating without a mouse must be able to predictably tab through sidebars, top navigation rails, and main panels.
- **Consistent Help (Criterion 3.2.6 - A)**: If you provide support contact forms or documentation links, they must stay in the exact same layout position relative to the global workspace view across all windows and screens.

---
## 🛠️ Native Android Developer Implementation Checklist
To meet WCAG 2.2 standards universally across all targets, build your layouts using this checklist:

**🎨 Contrast & Scaling**
- Ensure text contrast hits 4.5:1 (Level AA) or 7:1 (Level AAA)
- Avoid setting rigid heights on containers so text scales up elegantly via Dynamic Type

**🔀 Semantics Management**
- Wrap non-standard interactive composables with a explicit `Semantics` composable
- Mask purely cosmetic layout shapes and background illustrations via `ExcludeSemantics`

**🧑🦽 Input & Interactivity**
- Make click targets at least 48x48 points on mobile devices
- Map distinct `FocusNodes` to complex grid sections to ensure clean keyboard tab navigation
