import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:core_testing/mock_dio_client.dart';
import 'package:core_testing/test_bootstrap.dart';

// Note: In a real sociable test, you would import the BLoC and Repository from the feature package.
// import 'package:lego_list/bloc/lego_list_bloc.dart';
// import 'package:lego_list/repository/lego_list_repository.dart';

void main() {
  late MockDioClient mockDio;

  setUp(() {
    // 1. Initialize the shared dependencies
    mockDio = bootstrapSociableTest();
  });

  group('LegoList Sociable Test (Architecture Validation)', () {
    test('MockDioClient successfully intercepts and returns mock data', () async {
      // Arrange: Configure the mock to return a specific JSON payload
      final fakePayload = {
        "status": "success",
        "data": [
          {"name": "Millennium Falcon", "theme": "Star Wars"}
        ]
      };
      mockDio.mockGetSuccess(path: '/api/v1/legos', data: fakePayload);

      // Act: Simulate a repository making a network call
      final response = await mockDio.get('/api/v1/legos');

      // Assert: Verify the mocked network layer intercepted it perfectly
      expect(response.statusCode, 200);
      expect(response.data['status'], 'success');
      expect((response.data['data'] as List).first['name'], 'Millennium Falcon');
    });

    test('MockDioClient successfully throws configured DioExceptions', () async {
      // Arrange
      final fakeError = DioException(
        requestOptions: RequestOptions(path: '/api/v1/legos'),
        type: DioExceptionType.connectionTimeout,
      );
      mockDio.mockGetError(path: '/api/v1/legos', error: fakeError);

      // Act & Assert
      expect(
        () async => await mockDio.get('/api/v1/legos'),
        throwsA(isA<DioException>()),
      );
    });
  });
}
