---
name: Setup Sociable Testing Structure
description: Sets up the foundation for sociable testing, including URLProtocol mocking.
---

# Setup Sociable Testing Structure

This workflow initializes the project for sociable testing by mocking the native `URLSession`.

## Step 1: Scaffold Test Directories
Create `Tests/Helpers/` and `Tests/Fixtures/`.

## Step 2: Create MockURLProtocol
Create `Tests/Helpers/MockURLProtocol.swift` that subclasses `URLProtocol`.
This class should intercept requests and return pre-configured `Data` and `HTTPURLResponse` objects.

## Step 3: Configure URLSession
Provide a helper to create a `URLSession` that uses `MockURLProtocol`:
```swift
let config = URLSessionConfiguration.ephemeral
config.protocolClasses = [MockURLProtocol.self]
let session = URLSession(configuration: config)
```
