---
description: Increment the build number in pubspec.yaml
---

1. Read `pubspec.yaml` to find the current version.
2. Locate the `version:` line (e.g., `version: 1.0.21+64`).
3. Increment the build number (the number after the `+`). For example, change `+64` to `+65`.
4. Save the file.
5. Stage the change and push with summarized & comprehensive message
git status -> git add . -> git diff -> generate comprehensive, human-readable message w.r.t. git diff using PARSV (Problem - Actions - Root-cause - Solution - Verification) Method -> git commit -> git push