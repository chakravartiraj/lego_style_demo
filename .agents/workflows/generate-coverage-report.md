---
name: Generate Coverage Report
description: Generates a full test coverage report using xccov.
---

# Generate Coverage Report

This workflow generates a test coverage report for the iOS project.

## Step 1: Run Tests with Coverage Enabled
1. Execute the command:
   ```bash
   xcodebuild test -project LegoStyleDemo.xcodeproj -scheme LegoStyleDemo -destination 'platform=iOS Simulator,name=iPhone 13 Pro Max' -enableCodeCoverage YES -derivedDataPath build
   ```

## Step 2: View Coverage Report
1. Use `xcrun xccov` to view the report:
   ```bash
   xcrun xccov view --report build/Logs/Test/*.xcresult
   ```

## Step 3: Present Findings
1. Analyze the output and present the line coverage percentages for the main app modules to the user.
