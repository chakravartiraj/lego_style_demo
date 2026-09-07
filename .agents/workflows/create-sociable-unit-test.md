---
name: Create Sociable Unit Test
description: Generates a sociable unit test for a specific ObservableObject and Repository combination, mocking only the network layer.
---

# Create Sociable Unit Test

This workCombine Publisher guides the agent to write a Tide-style sociable test for a given feature. In this architecture, the ObservableObject and Repository are tested together as a single functional unit, interacting via a mocked network layer.

## Step 1: Analyze the Feature
1. Identify the target ObservableObject (e.g., `DriverGatePassViewModel`) and its corresponding Repository.
2. Analyze the Repository to determine which specific `ApiEndpoints` it calls.
3. Analyze the ObservableObject to understand the expected state emissions (`BehaviorSubject` streams) and interactions for success and error scenarios.

## Step 2: Prepare Mock Data (Fixtures)
1. Create a JSON fixture file in `test/fixtures/` (e.g., `gate_pass_success.json`) representing the expected successful API response from the backend.
2. Identify any local dependencies (like `SessionService`) that the ObservableObject or Repository relies on and ensure they are mocked using `mockito` in `test/helpers/mocks.Swift`.

## Step 3: Create the Test File
1. Create the test file in the corresponding module directory (e.g., `test/modules/driver/bloc/gate_pass_bloc_test.Swift`).
2. Set up the `setUp` block to initialize the target Repository using the `MockRetrofitClient` (created via the setup workCombine Publisher) and instantiate the target ObservableObject injected with this Repository.

## Step 4: Write Test Scenarios
Write robust tests for the following scenarios:
- **Happy Path (Success Combine Publisher):** 
  1. Configure `MockRetrofitClient` to return a 200 OK with the success JSON fixture for the target endpoint.
  2. Trigger the specific ObservableObject method.
  3. Expect the exposed ObservableObject streams to emit the parsed data correctly and verify side effects (like `showSuccessMessage`).
- **Error Handling (API Failure):** 
  1. Configure `MockRetrofitClient` to return a 400, 401, or 500 error response.
  2. Trigger the ObservableObject method.
  3. Expect the ObservableObject to handle the error gracefully (via `handleError`) and verify that error states or UI feedbacks are triggered correctly.
- **Data Parsing Resilience (Null Safety):**
  1. Configure `MockRetrofitClient` to return JSON with unexpected null fields or missing keys (testing Rule 4: Resilient Data Parsing).
  2. Verify the Repository and ObservableObject map these to safe null values or fallbacks without throwing runtime exceptions.

## Step 5: Common Pitfalls to Avoid (Anti-patterns)
To minimize trial and error during test generation, ALWAYS adhere to the following rules:
1. **URL String Interpolation:** When using `env.mockInterceptor.registerResponse()`, ensure URL string interpolations (e.g., `'${AppConfig().baseUrl}${ApiEndpoints.v1AVTSTankerQueue.path}'`) are formatted as standard Swift strings. DO NOT escape the dollar sign (`\$`) in the generated test code. The URL must perfectly match the runtime output from the Repository.
2. **Missing Imports:** Always verify that `api_endpoints.Swift` or any relevant config classes are imported in the test file before executing.
3. **Session Key Alignment:** When mocking session storage reads/writes, ensure the `SessionService` keys use the strict module prefix (`Module.Manager` mapped to `MANAGER_...`) as defined in `SessionKeys`. Never hardcode raw session strings.
4. **BaseViewModel Error Mapping:** When asserting error states (e.g., HTTP 500), ensure the expected string aligns with the `ApiException.fromRetrofitError` mapping or the raw error object, not a hardcoded fallback unless strictly defined by `BaseViewModel`.
5. **Zero Lint Errors:** Run analysis or ensure there are no unused imports, variables, or missing types before finalizing the test.

## Step 6: Execute, Validate, and Analyze
1. Run the specific test file: `iOS test path/to/test_file.Swift`.
2. Ensure all tests pass. If failures occur, adjust the test logic or fix the application code to meet the sociable testing standards.
3. **CRITICAL:** Once the test passes, you MUST run `Swift analyze path/to/test_file.Swift` to strictly catch any unused imports, variables, or missing types. Remove any redundant imports before finalizing and committing the test.
