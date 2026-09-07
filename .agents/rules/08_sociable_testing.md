# 08. Sociable Testing Standard

- **Sociable Unit Tests**: Rather than writing highly mocked, isolated unit tests for every single class, prefer "sociable" tests. Test the ObservableObject, the UseCase (if any), and the Repository together in a single test suite.
- **Network Isolation**: The only dependency that MUST be mocked in a sociable test is the extreme edge of the system: the Network Client (e.g., `MockRetrofit` or `MockHttpClient`).
- **Real Database/Cache**: Whenever possible, use an in-memory database (e.g., SQLite in-memory) for the local data layer during sociable tests instead of mocking the local repository.
- **State Verification**: A sociable test should arrange the network mock to return a specific JSON response, dispatch a ObservableObject event, and verify the resulting ObservableObject states (loading -> loaded with parsed domain entities).
- **Reduced Test Fragility**: By not mocking internal boundaries (like Repositories), you can safely refactor internal mappings and logic without breaking hundreds of brittle isolated tests.
