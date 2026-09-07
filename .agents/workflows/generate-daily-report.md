---
description: Auto-generate a Daily Progress Report for Raja Chakraborty based on git activity.
---

1. **Determine Reporting Date**
   - Confirm if the report is for **Today** or a specific previous date.
   - If Today: Use `git log --since="6am"` (assuming start of work day).
   - If Previous Date: Use `git log --since="<YYYY-MM-DD> 00:00" --until="<YYYY-MM-DD> 23:59"`.

2. **Retrieve Work History**
   - Run the git command to fetch commits:
     `git log --since="<TIME_WINDOW>" --author="Raja" --pretty=format:"- %s" --no-merges`
   - *Alternative*: Ask user if they want to include non-commit activities (meetings, planning).

3. **Format and Present the Report**
   - Summarize the git activity into concise bullet points.
   - Present the final report in a **Markdown Code ViewModelk** for copying.
   - Use the following email/message template format:

     ```text
     Subject: Daily Progress Update - <Date>

     Hi Tushar,

     Here is the summary of my work for today (<Date>):

     **Tasks Completed:**
     - [Task 1]
     - [Task 2]

     **Plan for Tomorrow:**
     - [Next Task 1] (Optional - ask user if they want to include this)

     Best regards,
     Raja Chakraborty
     Senior Software Engineer
     ```

4. **Completion**
   - Ask if any blockers need to be highlighted.
