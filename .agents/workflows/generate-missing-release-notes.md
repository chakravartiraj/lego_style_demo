---
description: Fetch undocumented commits and generate neatly categorized daily release note files using AI.
---

1. **Identify Existing Notes**: 
   - Check the `release_notes/` directory.
   - Identify all dates (YYYY-MM-DD) that already have a file named `hmwssb_tankerservice_{DATE}.md`.

2. **Fetch Commits**:
   - Run `git log` to fetch the git commit history, ensuring you include the date, hash, and full commit message.
   - Example command: `git log --pretty=format:"%Y-%m-%d|%h|%s%n%b"`
   - Group the commits by date.

3. **Filter Undocumented Dates**:
   - Identify dates that have commits but lack a corresponding release note file in the `release_notes/` directory.

4. **AI Processing & Generation**:
   For each undocumented date with commits:
   - Analyze the PARSV-formatted commit messages for that date.
   - Categorize the commits based on their type/prefix:
     - **Features** (`feat`)
     - **Bug Fixes** (`fix`, `bug`)
     - **Technical Changes / Maintenance** (`chore`, `refactor`, `test`, `build`, `style`, `ci`)
     - **Documentation** (`docs`)
     - **Other Commits**
   - Use the `write_to_file` tool to create `release_notes/kow_mobile_{DATE}.md` with the following structure:
     - Title: `# Release Notes - {DATE}`
     - Section: `## Overview` (A brief summary that these notes summarize changes committed on that date).
     - Section: `## {Category}` (for each applicable category).
     - Under each category, list the commit subject with its hash. If the PARSV message contains `Problem` or `Solution` sections, extract and list them as nested bullet points under the commit.

5. **Review and Finalize**:
   - Once all missing release note files are generated, notify the user.
   - Provide a summary of which dates were generated and how many files were created.