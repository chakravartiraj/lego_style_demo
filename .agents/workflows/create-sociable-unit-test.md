---
name: Create Sociable Unit Test
description: Generates a sociable unit test for a specific ObservableObject and Repository combination, mocking only the network layer.
---

# Create Sociable Unit Test

This workflow guides the agent to write a sociable test. In this architecture, the ViewModel and Repository are tested together as a single functional unit, interacting via a mocked network layer using `URLProtocol`.

## Step 1: Analyze the Feature
1. Identify the target `ObservableObject` and its Repository.
2. Analyze the expected state emissions and network requests.

## Step 2: Prepare Mock Data (Fixtures)
1. Create a JSON fixture file in `Tests/Fixtures/` (e.g., `success_response.json`).
2. Register the mock response using your custom `MockURLProtocol`.

## Step 3: Create the Test File
1. Create the test file in `Tests/Modules/` (e.g., `GatePassViewModelTests.swift`).
2. Ensure you import `XCTest`.
3. Set up the `setUp()` block to inject a `URLSession` configured with `MockURLProtocol` into your Repository.

## Step 4: Write Test Scenarios
Write robust tests for the following using `async/await`:
- **Happy Path:** Configure `MockURLProtocol` to return 200 OK. Assert the ViewModel's state updates correctly.
- **Error Handling:** Configure `MockURLProtocol` to return a 500 status code. Assert the ViewModel emits the proper error state.

## Step 5: Execute
Run the test:
```bash
xcodebuild test -project LegoStyleDemo.xcodeproj -scheme LegoStyleDemo -destination 'platform=iOS Simulator,name=iPhone 13 Pro Max'
```
