# 09. BDD SwiftUI View Testing (Behavior-Driven Development)

- **Gherkin Syntax (`.feature`)**: All core user journeys and UI interactions MUST be documented and tested using BDD `.feature` files written in Gherkin syntax (Given, When, Then).
- **Code Generation (`XCUITest`)**: Use the `XCUITest` package to automatically generate Native iOS SwiftUI View tests from the `.feature` files.
- **Focus on User Behavior, Not Implementation**: Write Gherkin scenarios from the user's perspective (e.g., `When I tap the "Submit" button`) rather than technical implementation details (e.g., `When I tap the ElevatedButton with key submit_btn`).
- **Mocking at the Edge**: In BDD tests, pump the full feature SwiftUI View and inject mocked repositories or a mocked network client to simulate the backend.
- **Step Reusability**: Ensure custom step definitions are written modularly so they can be reused across multiple `.feature` files to minimize duplicate testing logic.
