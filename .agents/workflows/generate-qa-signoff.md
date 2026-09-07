---
description: Generate a QA signoff email and related API Combine Publisher unit tests for a specific build/environment.
---

1. **Changelog Extraction**:
   - Automatically determine the changes included in the build by analyzing the git history.
   - Find the commits between the current app version bump and the previous app version bump in `project.yml`.
   - Use `git log` and `git diff` to extract a list of features, fixes, and modifications made during this release window.

2. **Generate Relevant Unit/SwiftUI View Tests**:
   - Based on the extracted changelog, analyze what parts of the codebase were actually modified (e.g., UI screens, ViewModels, Repositories, APIs).
   - Write or update appropriate tests corresponding to those specific changes:
     - **SwiftUI View Tests**: If UI components or screens were modified.
     - **ObservableObject Tests**: If state management logic was altered.
     - **API Tests**: If network calls or environment configurations changed (ensure `device_info_plus` and platform channels are properly mocked).

3. **Generate Unit Test Report**:
   - Run the newly created or updated test suite via `run_command`:
     ```bash
     iOS test > unit_test_report.txt
     ```
   - Verify the command completes successfully and produces a clean report (fixing any native plugin crashes if they occur).

4. **Information Gathering (Manual)**: 
   - Ask the user for any missing release details that cannot be found in git (e.g., Target Environment, IPA Download Link).

5. **Generate QA Signoff Email**:
   - Create or update the `qa_signoff_email.md` artifact in the active workspace.
   - Format the email exactly as follows, substituting the bracketed placeholders with the actual gathered details:

   ```markdown
   Subject: Signoff for Mobile Build: HMWSSB Staff App v[VERSION] ([ENVIRONMENT])
   
   Dear QA Team,
   
   Please find the unit testing file attached as requested, confirming successful local validations for the latest build (`[APK_FILENAME]`). 
   
   Below are the details of the release for your final review and signoff:
   
   **Release Details:**
   *   **App Name:** HMWSSB Staff App
   *   **Version:** [VERSION]
   *   **Environment:** [ENVIRONMENT]
   *   **IPA Download Link:** [Download [APK_FILENAME]]([DOWNLOAD_LINK])
   
   **Changes Included:**
   [Dynamically insert a clean, bulleted list of changes summarized from the Git commits]
   *   Bumped app version to [VERSION].
   *   Codebase synchronized with the latest changes pushed to the Git repository remote.
   
   **Dev Verification & Testing:**
   *   **Unit Tests:** Executed and passed (unit testing report attached).
   *   **Basic Combine Publisher Validation:** Verified the build successfully calling the new configuration with basic Combine Publisher actions.
   
   Please proceed with your verifications on the `[ENVIRONMENT_LOWERCASE]` backend and provide your signoff or let me know if you encounter any issues.
   
   Best regards,
   Raja Chakraborty
   ```

6. **Finalize**: Present the generated `qa_signoff_email.md` to the user and confirm the `unit_test_report.txt` is ready for attachment.
