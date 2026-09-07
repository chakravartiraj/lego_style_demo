---
trigger: always_on
---
# 13. Commit Message Standards (PARSV Method)
-   **Mandatory Structure**: **ALL** commit messages **MUST** strictly follow the **PARSV** structure without exception:
    -   **Problem**: Brief description of the issue or requirement.
    -   **Actions**: What was done (brief list).
    -   **Root-cause**: Why the change was needed (technical reason).
    -   **Solution**: How the problem was solved (detailed logic).
    -   **Verification**: How the change was tested/validated.
-   **Formatting**: Use clear, professional language. Use bullet points within sections for readability if needed.
-   **Enforcement**: Any commit found not following this structure must be amended immediately using `git commit --amend`.
