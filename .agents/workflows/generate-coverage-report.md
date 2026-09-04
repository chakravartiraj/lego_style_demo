---
name: Generate Coverage Report
description: Generates a full test coverage report for the Flutter project and outputs it to HTML.
---

# Generate Coverage Report

This workflow guides the agent to generate and present a comprehensive test coverage report for the HMWSSB Tanker Service project.

## Step 1: Run Flutter Tests with Coverage
1. Execute the command: `flutter test --coverage`
2. Wait for the command to finish. This will run all the unit and widget tests in the `test/` directory and output the `lcov.info` file in the `coverage/` directory.

## Step 2: Generate HTML Report
1. Convert the `lcov.info` file into a readable HTML format using `genhtml`.
2. Execute the command: `genhtml coverage/lcov.info -o coverage/html`
3. This creates a detailed line-by-line coverage breakdown in `coverage/html/index.html`.

## Step 3: Present Coverage Findings
1. Analyze the output of the `genhtml` command, paying special attention to overall line coverage percentage.
2. If `genhtml` is not available, summarize the coverage by parsing the `lcov.info` using standard tools, or direct the user to view it using their IDE's coverage tools (e.g. Coverage Gutters in VS Code).
3. Identify modules (Driver, In-Charge, Manager, Owner, Staff Shared) that require more testing focus based on low coverage numbers.
4. Report the findings to the user clearly.
