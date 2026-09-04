import 'mock_dio_client.dart';

/// Bootstraps standard dependencies required for sociable testing across the monorepo.
/// Returns a freshly initialized [MockDioClient] that can be wired into a target Repository.
MockDioClient bootstrapSociableTest() {
  final mockDio = MockDioClient();
  
  // Note: Future expansions can initialize standard Auth mocks, Storage mocks, 
  // or setup GetIt locator overrides here for all feature packages to inherit.
  
  return mockDio;
}
