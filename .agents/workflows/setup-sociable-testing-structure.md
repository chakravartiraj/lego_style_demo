---
name: Setup Sociable Testing Structure
description: Sets up the foundation for Tide-like sociable testing in the test/ directory, including dependencies and MockDio client.
---

# Setup Sociable Testing Structure

This workflow guides the agent to initialize the `hmwssb_tankerservice` project for sociable testing (testing BLoCs and Repositories together by mocking the Dio network layer).

## Step 1: Verify Dependencies
1. Check `pubspec.yaml` to ensure `mockito` and `build_runner` are present in `dev_dependencies`.
2. If missing, run `flutter pub add --dev mockito build_runner`.

## Step 2: Scaffold Test Directories
Create the following directory structure inside the `test/` folder if it doesn't exist:
- `test/helpers/`: For common test utilities, mock network clients, and generated mock setups.
- `test/fixtures/`: For JSON payload files representing API responses.
- `test/modules/`: To mirror the `lib/modules/` structure for actual test files.

## Step 3: Create Mock Dio Client
To enable sociable testing, we must mock the network layer (`Dio`) so that repositories can function without live API calls, ensuring the data flows correctly from parsing to BLoC state emission.
1. Create `test/helpers/mock_dio_client.dart`.
2. Implement a customized mock `Dio` adapter or `Interceptor` that intercepts requests to endpoints defined in `ApiEndpoints` and returns pre-configured JSON responses or HTTP errors.
3. Ensure the mock client has helper methods to easily stage success, failure, or timeout responses per test.

## Step 4: Create Base Test Helpers
1. Create `test/helpers/test_bootstrap.dart`.
2. Implement a helper function (e.g., `bootstrapSociableTest()`) that initializes standard dependencies required by all tests (like mocking the `SessionService` for auth tokens) and helps wire the `MockDioClient` into any target Repository.

## Step 5: Verification
1. Run `flutter test` to ensure the basic setup is sound and no syntax errors or conflicts were introduced.
