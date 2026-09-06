---
name: Create Sociable Unit Test
description: Generates a sociable unit test for a specific BLoC and Repository combination, mocking only the network layer.
---

# Create Sociable Unit Test

This workflow guides the agent to write a Tide-style sociable test for a given feature. In this architecture, the BLoC and Repository are tested together as a single functional unit, interacting via a mocked network layer.

## Step 1: Analyze the Feature
1. Identify the target BLoC (e.g., `DriverGatePassBloc`) and its corresponding Repository.
2. Analyze the Repository to determine which specific `ApiEndpoints` it calls.
3. Analyze the BLoC to understand the expected state emissions (`BehaviorSubject` streams) and interactions for success and error scenarios.

## Step 2: Prepare Mock Data (Fixtures)
1. Create a JSON fixture file in `test/fixtures/` (e.g., `gate_pass_success.json`) representing the expected successful API response from the backend.
2. Identify any local dependencies (like `SessionService`) that the BLoC or Repository relies on and ensure they are mocked using `mockito` in `test/helpers/mocks.dart`.

## Step 3: Create the Test File
1. Create the test file in the corresponding module directory (e.g., `test/modules/driver/bloc/gate_pass_bloc_test.dart`).
2. Set up the `setUp` block to initialize the target Repository using the `MockDioClient` (created via the setup workflow) and instantiate the target BLoC injected with this Repository.

## Step 4: Write Test Scenarios
Write robust tests for the following scenarios:
- **Happy Path (Success Flow):** 
  1. Configure `MockDioClient` to return a 200 OK with the success JSON fixture for the target endpoint.
  2. Trigger the specific BLoC method.
  3. Expect the exposed BLoC streams to emit the parsed data correctly and verify side effects (like `showSuccessMessage`).
- **Error Handling (API Failure):** 
  1. Configure `MockDioClient` to return a 400, 401, or 500 error response.
  2. Trigger the BLoC method.
  3. Expect the BLoC to handle the error gracefully (via `handleError`) and verify that error states or UI feedbacks are triggered correctly.
- **Data Parsing Resilience (Null Safety):**
  1. Configure `MockDioClient` to return JSON with unexpected null fields or missing keys (testing Rule 4: Resilient Data Parsing).
  2. Verify the Repository and BLoC map these to safe null values or fallbacks without throwing runtime exceptions.

## Step 5: Common Pitfalls to Avoid (Anti-patterns)
To minimize trial and error during test generation, ALWAYS adhere to the following rules:
1. **URL String Interpolation:** When using `env.mockInterceptor.registerResponse()`, ensure URL string interpolations (e.g., `'${AppConfig().baseUrl}${ApiEndpoints.v1AVTSTankerQueue.path}'`) are formatted as standard Dart strings. DO NOT escape the dollar sign (`\$`) in the generated test code. The URL must perfectly match the runtime output from the Repository.
2. **Missing Imports:** Always verify that `api_endpoints.dart` or any relevant config classes are imported in the test file before executing.
3. **Session Key Alignment:** When mocking session storage reads/writes, ensure the `SessionService` keys use the strict module prefix (`Module.Manager` mapped to `MANAGER_...`) as defined in `SessionKeys`. Never hardcode raw session strings.
4. **BaseBloc Error Mapping:** When asserting error states (e.g., HTTP 500), ensure the expected string aligns with the `ApiException.fromDioError` mapping or the raw error object, not a hardcoded fallback unless strictly defined by `BaseBloc`.
5. **Zero Lint Errors:** Run analysis or ensure there are no unused imports, variables, or missing types before finalizing the test.

## Step 6: Execute, Validate, and Analyze
1. Run the specific test file: `flutter test path/to/test_file.dart`.
2. Ensure all tests pass. If failures occur, adjust the test logic or fix the application code to meet the sociable testing standards.
3. **CRITICAL:** Once the test passes, you MUST run `dart analyze path/to/test_file.dart` to strictly catch any unused imports, variables, or missing types. Remove any redundant imports before finalizing and committing the test.
