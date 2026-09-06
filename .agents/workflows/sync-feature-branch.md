---
description: Synchronize a feature branch with the latest changes from a source branch
---

# Workflow: Sync Feature Branch (Cherry-Pick)

Synchronize a feature branch with the latest changes from a source branch (e.g., `main`) using a sequential cherry-pick strategy. This method is preferred when a clean history is required without merge commits.

## Steps

1.  **Identify Target Branch**: Determine the name of the feature branch that needs synchronization.
2.  **Checkout Feature Branch**:
    ```bash
    git checkout <feature-branch-name>
    ```
3.  **Identify Missing Commits**: List the commits that exist on the source branch (usually `main`) but are missing from the feature branch.
    ```bash
    git log <feature-branch-name>..main --oneline
    ```
4.  **Sequential Cherry-Pick**:
    - Identify the commit hashes from the previous step.
    - **Crucial**: Reverse the order to apply them from oldest to newest.
    - Execute the cherry-pick:
    ```bash
    git cherry-pick <hash1> <hash2> <hash3> ...
    ```
5.  **Handle Conflicts**:
    - If the cherry-pick stops due to conflicts, resolve them in the affected files.
    - Stage the resolved files: `git add <file>`.
    - Continue the process: `git cherry-pick --continue`.
6.  **Verify Integrity**:
    - Run static analysis to ensure no regressions were introduced.
    ```bash
    flutter analyze
    ```
7.  **Push Updates**:
    - Once all commits are applied and verified, push the synchronized branch to the remote.
    ```bash
    git push origin <feature-branch-name>
    ```

## Usage Notes
- Use this workflow when you want to bring specific features or fixes from `main` into your work-in-progress branch without merging the entire history of `main`.
- If the number of commits is large, consider a `merge` or `rebase` instead, unless project rules strictly enforce cherry-picking.
