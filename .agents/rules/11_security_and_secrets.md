# 11. Security & Secrets Management

- **No Hardcoded Secrets**: **NEVER** commit API keys, auth tokens, or sensitive endpoint URLs into the source code repository.
- **Configuration Files**: Use `.xcconfig` files to inject environment-specific configurations at build time. Ensure all `.xcconfig` files containing secrets are added to `.gitignore`.
- **Secure Storage**: All sensitive user data (Access Tokens, Refresh Tokens, PII) MUST be stored using the iOS `Keychain`. Never store sensitive tokens in `UserDefaults`.
- **Certificate Pinning**: For highly sensitive operations, enforce SSL/TLS certificate pinning using `URLSessionDelegate`.
