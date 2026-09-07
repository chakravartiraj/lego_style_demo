---
name: Create XCUITest
description: Generates a UI test for a SwiftUI View using XCUITest.
---

# Create XCUITest

This workflow guides the agent to write an `XCUITest` to simulate user interactions on a SwiftUI View.

## Step 1: Identify the View
1. Identify the screen to be tested (e.g., `DriverDashboardView.swift`).
2. Ensure the interactive elements in the SwiftUI view have `.accessibilityIdentifier("my_button")` applied.

## Step 2: Create the Test File
1. Create the file in the `UITests/` target (e.g., `DriverDashboardUITests.swift`).
2. Set up `XCUIApplication()` in the `setUpWithError()` method.

## Step 3: Write Test Scenarios
- **Scenario:** Driver sees empty state.
  ```swift
  func testEmptyState() throws {
      let app = XCUIApplication()
      app.launchArguments = ["-mockNetwork", "true"]
      app.launch()
      
      let emptyText = app.staticTexts["No trips found"]
      XCTAssertTrue(emptyText.waitForExistence(timeout: 5))
  }
  ```

## Step 4: Execute
Run the UI tests:
```bash
xcodebuild test -project LegoStyleDemo.xcodeproj -scheme LegoStyleDemoUITests -destination 'platform=iOS Simulator,name=iPhone 13 Pro Max'
```
