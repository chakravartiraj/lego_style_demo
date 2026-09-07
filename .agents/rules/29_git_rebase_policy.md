# 29. Git Rebase Policy

- **Core Principle**: To maintain a clean, linear git history, **ALWAYS** prefer rebasing over merging.
- **Implementation**: When syncing branches, use `git pull --rebase` and `git rebase <branch>` instead of `git merge`. Avoid creating unnecessary merge commits unless explicitly requested by the user.
