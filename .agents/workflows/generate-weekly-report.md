---
description: Auto-generate a Weekly Progress Report for Raja Chakraborty based on git activity.
---

1. **Determine Reporting Period**
   - Ask the user for the date range (e.g., "Dec 15 - Dec 19, 2025") if not currently known.

2. **Retrieve Work History**
   - Run the following command to fetch commits for that period (adjusting dates as needed):
     `git log --since="<START_DATE>" --until="<END_DATE>" --author="Raja" --pretty=format:"- %s" --no-merges`
   - *Alternative*: Ask the user to list key tasks if git history is incomplete or if they want to summarize manually.

3. **Format and Present the Report**
   - Summarize the git activity into professional bullet points (e.g., "Completed X", "Resolved Y").
   - Present the final report in a **Markdown Code ViewModelk** for easy one-click copying.
   - Use the following email template format:

     ```text
     Subject: Monthly Timesheet & Weekly Progress Summary (<Start> - <End>)

     Greetings Tushar,

     Please find attached my updated and daily maintained Monthly Timesheet for your reference.

     Below is the weekly progress summary for the period <Start> - <End>:

     Weekly Progress Summary:
     - [Task 1]
     - [Task 2]
     - [Task 3]

     Please let me know if you need any additional details or clarifications.

     Best regards,
     Raja Chakraborty
     Senior Software Engineer
     ```

4. **Completion**
   - Remind the user to attach their timesheet file before sending.
