---
description: Increment the build number in project.yml
---

1. Read `app/project.yml` to find the current version.
2. Locate the `versionCode = ` line.
3. Increment the integer value of `versionCode`. For example, change `versionCode = 1` to `versionCode = 2`.
4. Save the file.
5. Stage the change and push with summarized & comprehensive message
git status -> git add . -> git diff -> generate comprehensive, human-readable message w.r.t. git diff using PARSV (Problem - Actions - Root-cause - Solution - Verification) Method -> git commit -> git push