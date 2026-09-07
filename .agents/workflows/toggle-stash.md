---
description: Toggle between Stashing local changes and Unstashing (popping) the latest stash.
---

1. Check the git status and stash list to determine the action.
   - If there are modified/staged files: **Stash** them.
   - If the working directory is clean and a stash exists: **Pop** the latest stash.

2. Run the decision logic:
   ```bash
   if [[ -n $(git status --porcelain) ]]; then
       echo "Changes detected. Stashing..."
       git stash push -m "Auto-stashed by Toggle Workflow"
   else
       if [[ -n $(git stash list) ]]; then
           echo "No local changes. Popping latest stash..."
           git stash pop
       else
           echo "Nothing to stash and no stash to pop."
       fi
   fi
   ```
