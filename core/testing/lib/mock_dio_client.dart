import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class FallbackRequestOptions extends Fake implements RequestOptions {}

/// A robust Mock implementation of the Dio HTTP Client for Sociable Testing.
/// Allows injecting specific HTTP responses (success or error) into Repositories.
class MockDioClient extends Mock implements Dio {
  MockDioClient() {
    registerFallbackValue(FallbackRequestOptions());
  }

  /// Helper to mock a successful GET request with a specific JSON payload.
  void mockGetSuccess({
    required String path,
    required dynamic data,
    int statusCode = 200,
  }) {
    when(() => get(
          path,
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
          onReceiveProgress: any(named: 'onReceiveProgress'),
        )).thenAnswer((_) async => Response(
          requestOptions: RequestOptions(path: path),
          data: data,
          statusCode: statusCode,
        ));
  }

  /// Helper to mock a failed GET request.
  void mockGetError({
    required String path,
    required DioException error,
  }) {
    when(() => get(
          path,
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
          cancelToken: any(named: 'cancelToken'),
          onReceiveProgress: any(named: 'onReceiveProgress'),
        )).thenThrow(error);
  }
}
