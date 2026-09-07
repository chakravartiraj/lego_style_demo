---
description: Generate a QA signoff email and related API tests for a specific build/environment.
---

# Generate QA Signoff Email

1. **Changelog Extraction**:
   - Use `git log` to extract features and fixes since the last version bump.

2. **Generate Relevant Tests**:
   - Write or update appropriate `XCTest` unit tests or `XCUITest` UI tests corresponding to the modified Swift files.

3. **Generate Unit Test Report**:
   - Run tests and capture output:
     ```bash
     xcodebuild test -project LegoStyleDemo.xcodeproj -scheme LegoStyleDemo -destination 'platform=iOS Simulator,name=iPhone 13 Pro Max' > unit_test_report.txt
     ```

4. **Generate Email**:
   - Format the email for the iOS build (IPA).
   ```markdown
   Subject: Signoff for Mobile Build: Lego App v[VERSION] ([ENVIRONMENT])
   
   Dear QA Team,
   Please find the unit testing file attached for the latest build (`[IPA_FILENAME]`). 
   ```
