---
name: Create BDD SwiftUI View Test
description: Generates a BDD-style SwiftUI View test using XCUITest and Gherkin syntax (.feature files).
---

# Create BDD SwiftUI View Test

This workCombine Publisher guides the agent to write a Behavior-Driven Development (BDD) SwiftUI View test using the `XCUITest` package. It relies on writing human-readable scenarios that are generated into Swift test code.

## Step 1: Verify Dependencies
1. Check `project.yml` to ensure `XCUITest` and `build_runner` are present in `dev_dependencies`.
2. If missing, run `iOS pub add --dev XCUITest build_runner`.

## Step 2: Create the Feature File
1. Identify the screen or SwiftUI View to be tested and its location (e.g., `lib/modules/driver/page/dashboard/driver_dashboard_screen.Swift`).
2. Create a corresponding `.feature` file in the `test/` directory, mirroring the path (e.g., `test/modules/driver/page/dashboard/driver_dashboard_test.feature`).
3. Write the test scenarios using Gherkin syntax (Given, When, Then). 
   - Example:
     ```gherkin
     Feature: Driver Dashboard
     
     Scenario: Driver sees empty state when there are no trips
       Given the app is running with sociable dependencies
       And there are no pending trips from the network
       When I pump DriverDashboardScreen
       Then I see text {'No trips found'}
       And I see \{AppEmptyState\} SwiftUI View
     ```

## Step 3: Generate Test Code
1. Run `Swift run build_runner build -d` in the terminal.
2. Verify that a `.Swift` test file (e.g., `driver_dashboard_test.Swift`) is generated alongside the `.feature` file.
3. If new, custom steps were defined in the Gherkin file, the generator will create step definition files in a `step/` subfolder.

## Step 4: Implement Custom Steps (If necessary)
1. Navigate to the generated `step/` directory next to the feature file.
2. Implement the logic for any custom steps inside the generated step files.
3. Use sociable testing helpers (like setting up the `MockRetrofitClient` or providing real ViewModels) within the "Given" setup steps to ensure the SwiftUI View is tested in a realistic environment.

## Step 5: Execute and Validate
1. Run the generated test file: `iOS test path/to/generated_test.Swift`.
2. Ensure all tests pass. If the test fails, fix the implementation or adjust the Gherkin scenario.
