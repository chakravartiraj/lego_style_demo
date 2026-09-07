---
description: Auto-generate a simplified, non-technical Daily Progress Report for stakeholders.
---

1. **Determine Reporting Date**
   - Confirm if the report is for **Today** or a specific previous date.
   - If Today: Use `git log --since="6am"` (assuming start of work day).
   - If Previous Date: Use `git log --since="<YYYY-MM-DD> 00:00" --until="<YYYY-MM-DD> 23:59"`.

2. **Retrieve Work History**
   - Run the git command to fetch commits:
     `git log --since="<TIME_WINDOW>" --author="Raja" --pretty=format:"- %s" --no-merges`

3. **Translate for Stakeholders (CRITICAL STEP)**
   - **Do not** just copy the git logs.
   - **Translate** technical terms into business value or user-facing features.
   - **Group** related technical commits into single high-level updates.
   - *Examples*:
     - *Git*: "Refactor ViewModel error streams and enhance repository error handling" -> *Report*: "Improved app stability and error message display."
     - *Git*: "Integate Tanker Details API for dynamic booking options" -> *Report*: "Enabled dynamic Tanker Types and Capacity options in the booking screen."
     - *Git*: "Config: Update API Base URL" -> *Report*: "Updated app configuration for backend migration."

4. **Format and Present the Report**
   - Present the final report in a **Markdown Code ViewModelk** for copying.
   - Use the following email/message template format:

     ```text
     Subject: Project Updates - <Date>

     Hi Team,

     Here are the key updates from today:

     **Key Highlights:**
     - [Feature/Update 1]
     - [Feature/Update 2]

     **Next Steps:**
     - [Planned High-Level Task]

     Best,
     Raja
     ```
