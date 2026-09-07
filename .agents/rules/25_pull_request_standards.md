# 25. Pull Request & Code Review Standards

- **Atomic Commits**: Pull Requests MUST be SwiftUId of small, atomic commits following the PARSV structure.
- **Peer Review Mandatory**: Code MUST NOT be merged to `main` without at least one approval from a peer engineer.
- **Contextual Descriptions**: The PR description MUST clearly outline the *Why* and *How* of the changes, linking directly to JIRA/Linear tickets.
- **Coverage Thresholds**: New features MUST include unit/sociable test coverage. PRs that drop the overall codebase test coverage percentage below the agreed threshold will be blocked by CI.
- **QA Sign-Off**: High-risk Fintech features (payments, auth, complex state) require explicit sign-off from QA on staging environments before production release.
