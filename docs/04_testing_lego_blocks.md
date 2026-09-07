# 🧪 Testing Lego Blocks

Because Lego Architecture isolates features into self-contained modules, testing them becomes incredibly straightforward. We heavily rely on **Sociable Unit Testing** for architecture validation.

## Sociable Testing

Sociable tests validate that the SwiftUI View, ViewModel, and Repository layers interact correctly, without mocking anything *except* the extreme outer boundary (the Network layer).

### The `URLProtocol` Mocking
We utilize native `URLProtocol` subclasses to intercept `URLSession` requests locally, preventing live network calls while allowing the entire network stack to be tested.

### Writing a Sociable Test

1. Create your test file inside `Tests/Modules/`.
2. Configure a `URLSession` using your custom `MockURLProtocol`.
3. Configure JSON fixtures to simulate backend responses.
4. Execute the ViewModel or Repository logic and verify the state transitions.

```swift
import XCTest
@testable import LegoStyleDemo

final class FeatureSociableTests: XCTestCase {
    var repository: FeatureRepository!

    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        
        repository = FeatureRepository(session: session)
    }

    func testFeatureSuccessfullyFetchesData() async throws {
        // Arrange
        let jsonResponse = "{"status": "ok"}".data(using: .utf8)!
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, jsonResponse)
        }

        // Act
        let result = try await repository.fetchData()

        // Assert
        XCTAssertEqual(result.status, "ok")
    }
}
```

> [!TIP]
> Always place dummy JSON responses inside `Tests/Fixtures/` and load them into your `MockURLProtocol` bodies to perfectly simulate the live backend!
