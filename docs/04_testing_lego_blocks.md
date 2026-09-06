# 🧪 Testing Lego Blocks

Because Lego Architecture isolates features into self-contained Gradle modules, testing them becomes incredibly straightforward. We heavily rely on **Sociable Unit Testing** for architecture validation.

## Sociable Testing

Sociable tests validate that the Compose UI, ViewModel, and Repository layers interact correctly, without mocking anything *except* the extreme outer boundary (the Network layer).

### The `:core:testing` Module
We utilize a shared `:core:testing` module across the monorepo to prevent mocking boilerplate.
It provides:
- `MockWebServer` configurations to act as a local interceptor.
- `TestBootstrap.kt`: Initialization logic for standard dependencies.

### Writing a Sociable Test

1. Create your test file inside `feature/your_feature/src/test/java/...`.
2. Boot up the `MockWebServer`.
3. Configure JSON fixtures to simulate backend responses.
4. Execute the ViewModel or Repository logic (or launch the Composable using Robolectric/Paparazzi) and verify the state transitions.

```kotlin
import okhttp3.mockwebserver.MockWebServer
import okhttp3.mockwebserver.MockResponse
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.Assert.assertEquals

class FeatureSociableTest {
    private lateinit var mockWebServer: MockWebServer
    private lateinit var repository: FeatureRepository

    @Before
    fun setUp() {
        mockWebServer = MockWebServer()
        mockWebServer.start()
        
        // Inject the mock server's base URL into the Repository/Retrofit client
        repository = FeatureRepositoryImpl(baseUrl = mockWebServer.url("/").toString())
    }

    @After
    fun tearDown() {
        mockWebServer.shutdown()
    }

    @Test
    fun `Feature successfully fetches data via mocked network`() = runTest {
        // Arrange
        val mockResponse = MockResponse()
            .setResponseCode(200)
            .setBody("""{"status": "ok"}""")
        mockWebServer.enqueue(mockResponse)

        // Act
        val result = repository.fetchData()

        // Assert
        assertEquals("ok", result.status)
    }
}
```

> [!TIP]
> Always place dummy JSON responses inside `src/test/resources/fixtures/` and load them into your `MockResponse` bodies to perfectly simulate the live backend!
