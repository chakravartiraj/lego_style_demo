---
description: Increment the patch version number in pubspec.yaml
---

1. Read `pubspec.yaml` to find the current version.
2. Locate the `version:` line (e.g., `version: 1.0.21+64`).
3. Increment the patch version (the third number). For example, change `1.0.21` to `1.0.22`.
4. Keep the build number (the part after `+`) as is, or increment it if specifically requested.
5. Save the file.
6. Stage the change and push with summarized & comprehensive message
git status -> git add . -> git diff -> generate comprehensive, human-readable message w.r.t. git diff using PARSV (Problem - Actions - Root-cause - Solution - Verification) Method -> git commit -> git push