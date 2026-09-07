# 26. Mobile Engineering Standards

When you need to write custom logic or integrate hardware for the Native iOS application, strictly adhere to the following native engineering standards:

- **Structured Concurrency**: 
  - All asynchronous code MUST use Swift `async/await` and `Task`.
  - Ensure UI updates are pushed to the main thread using `@MainActor`.
- **Memory Management**:
  - Avoid retain cycles by using `[weak self]` in closures where necessary, though `Task` boundaries often alleviate this.
  - Cancel tasks using `Task.cancel()` in `.onDisappear` or `deinit`.
- **Offline Persistence**:
  - Use `SwiftData` or `CoreData` for robust offline structured persistence.
  - Do not use `UserDefaults` for anything other than basic preferences.
