---
description: Stage specific or all changes and generate a PARSV commit message for manual/auto commit.
---

1. **Determine Scope**: Analyze the user's request. Does it specify committing `staged` changes, `unstaged` changes, or `all` changes?
2. **Staging Logic**: 
   - If "all" or "unstaged" is requested (or if no scope is specified), run `git add .` to stage all current modifications.
   - If "staged" only is requested, skip the `git add .` step.
3. **Diff Analysis**: Run `git status` followed by `git diff --staged` to read the exact changes that will be summarized.
4. **Message Generation**: Generate a comprehensive commit message based on the git diff using the **PARSV** Method, following the exact structure of commits `5573df2` and `41506d5`:
   - **Summary Line**: Start with a type prefix (e.g., `feat:`, `fix:`, `refactor:`, `test:`, `chore:`, `docs:`) followed by a concise, imperative summary.
   - **Problem**: A descriptive "Problem:" section explaining the context and *why* this change is needed or what specific issue it solves (e.g., "The module lacked testing, which reduced confidence..."). Do not just restate the summary line.
   - **Actions**: A bulleted "Actions:" list of specific file/logic changes.
   - **Root-cause**: A "Root-cause:" section explaining the technical reason for the change.
   - **Solution**: A "Solution:" section detailing how the code addresses the problem.
   - **Verification**: A bulleted "Verification:" list of how the change was validated (e.g., tests, specific scenarios).
   - **Version Bump Changelog**: If `build.gradle.kts` is part of the staged changes (indicating a release or version bump), you MUST include an "Included in this release:" section detailing a clear summary of the major/minor/patch improvements bundled in this release for QA and IT review.
   - **No Agent Rule References**: Ensure that internal agent rules (e.g., "Rule 15", "Agent Rule 04") are NEVER explicitly mentioned by name or number in the commit message. Describe the principle (e.g., "DRY principle", "context safety") instead of citing the rule ID.
   - **Formatting**: Ensure a blank line between each section for readability.
5. **Copy-Paste Output**: Provide the generated commit message to the user for manual commit or subsequent turbo steps. Include the recommended execution sequence for them to run:
   ```bash
   git commit -m "[Your Message]"
   git pull --rebase
   git push
   ```