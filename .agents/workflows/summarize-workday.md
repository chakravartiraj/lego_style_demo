---
description: Chronologically summarize today's work based on git commit history.
---

1. **Retrieve Commit History**
   - Fetch today's commits in chronological order (oldest to newest):
     `git log --since="00:00" --reverse --pretty=format:"%h %ad | %s" --date=short`

2. **Analyze and Group**
   - Review each commit to understand the progression of work throughout the day.
   - Group related commits into logical work milestones (e.g., "Authentication Refactor", "UI Polishing").

3. **Generate Markdown Summary**
   - Create a structured markdown report with the following sections:
     - **Title**: Work Summary for <Today's Date>
     - **Chronological Breakdown**: A list of achievements ordered by time/workflow progression.
     - **Key Technical Highlights**: Specific improvements or fixes made.
     - **Final Status**: Current state of the repository (e.g., "All changes pushed to main").

4. **Output Final Result**
   - Display the generated summary directly to the user in the chat.
