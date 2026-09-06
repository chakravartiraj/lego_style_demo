# 🧪 Testing Lego Blocks

Because Lego Architecture isolates features into self-contained packages, testing them becomes incredibly straightforward. We heavily rely on **Sociable Unit Testing** for architecture validation.

## Sociable Testing

Sociable tests validate that the UI, BLoC, and Repository layers interact correctly, without mocking anything *except* the extreme outer boundary (the Network layer).

### The `core/testing` Package
We utilize a shared `core/testing` package across the monorepo to prevent mocking boilerplate.
It provides:
- `MockDioClient`: A robust network interceptor powered by `mocktail`.
- `test_bootstrap.dart`: Initialization logic for standard dependencies.

### Writing a Sociable Test

1. Create your test file inside `feature/your_feature/test/modules/`.
2. Boot up the `MockDioClient`.
3. Configure JSON fixtures to simulate backend responses.
4. Execute the BLoC or Repository logic and verify the state transitions.

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:core_testing/mock_dio_client.dart';
import 'package:core_testing/test_bootstrap.dart';

void main() {
  late MockDioClient mockDio;

  setUp(() {
    mockDio = bootstrapSociableTest();
  });

  test('Feature successfully fetches data via mocked network', () async {
    // Arrange
    mockDio.mockGetSuccess(path: '/api/v1/data', data: {"status": "ok"});

    // Act
    final response = await mockDio.get('/api/v1/data');

    // Assert
    expect(response.statusCode, 200);
  });
}
```

> [!TIP]
> Always place dummy JSON responses inside `test/fixtures/` and load them into your `mockGetSuccess` calls to perfectly simulate the live backend!
