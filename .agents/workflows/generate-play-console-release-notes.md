---
description: Generates a concise release note that fits the strict 500-character limit of the Google Play Console release notes field, based on all git commits between the two most recent version bump commits.
---

# Generate Play Console Release Notes

## Description
Generates a concise release note that fits the strict 500-character limit of the Google Play Console release notes field, based on all git commits between the two most recent version bump commits.

## Steps
1. **Identify Version Bump Commits**: 
   - Analyze the `git log` to find the two most recent commits that represent a version bump (e.g., commits containing "version bump", "bump version", "release version" in their message or modifying `pubspec.yaml` versions).
   - Let's call them `COMMIT_LATEST_BUMP` and `COMMIT_PREVIOUS_BUMP`.

2. **Retrieve Changes**:
   - Run `git log --oneline ${COMMIT_PREVIOUS_BUMP}..${COMMIT_LATEST_BUMP}` to retrieve all commits that went into this new release.

3. **Synthesize & Condense**:
   - Read the commit messages to understand the features, fixes, and improvements.
   - Synthesize these changes into a user-friendly format, categorizing them broadly if needed.

4. **Enforce Character Limit (CRITICAL)**:
   - Generate the release note text.
   - You MUST ensure the TOTAL length of the generated text (including spaces, newlines, and punctuation) is **STRICTLY UNDER 500 characters**.
   - If it exceeds 500 characters, aggressively rewrite and condense the points further. Prioritize the most user-facing and impactful changes. Group related fixes together and drop minor technical chores.

5. **Format Guidelines**:
   - Use a brief intro like "What's new in [Version]:"
   - Use bullet points (`•`) for readability.
   - Example format:
     ```text
     What's new in 1.2.32:
     • Fixed map recentering to accurately frame your entire route.
     • Improved map stability when partial tracking data is available.
     • Added stricter rules for tanker manufacturing dates and edits.
     • Enforced critical update prompts to keep you on the latest version.
     • Bug fixes and accessibility improvements.
     ```

6. **Output**:
   - Present the final release note to the user in a markdown code block so they can easily copy and paste it directly into the Google Play Console without any manual edits.
