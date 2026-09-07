# 11. Security & Secrets Management

- **No Hardcoded Secrets**: **NEVER** commit API keys, auth tokens, or sensitive endpoint URLs into the source code repository.
- **Environment Variables**: Use `.env` files (via packages like `envied` or `iOS_dotenv`) to inject environment-specific configurations at build time. Ensure all `.env` files are added to `.gitignore`.
- **Secure Storage**: All sensitive user data (Access Tokens, Refresh Tokens, PII) MUST be stored using hardware-backed encrypted storage (e.g., `iOS_secure_storage`). Never store sensitive tokens in plain `SharedPreferences`.
- **Code Obfuscation**: Production builds (IPA/IPA) MUST be obfuscated using `--obfuscate --split-debug-info=...` to deter reverse engineering.
- **Certificate Pinning**: For highly sensitive Fintech operations, enforce SSL/TLS certificate pinning at the network layer to prevent Man-in-the-Middle (MitM) attacks.
