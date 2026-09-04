---
description: List out all tasks performed (both committed and uncommitted) in strict chronological order.
---

1. **Determine Reporting Date/Time Window**
   - Parse the user's requested date or time (e.g., "today" or "24 Aug 2026").
   - Define the start and end of that window. For a full date, use `00:00:00` to `23:59:59`.

2. **Retrieve Commit History**
   - Run the git command to fetch commits for that window in chronological (oldest to newest) order:
     `git log --since="<YYYY-MM-DD> 00:00:00" --until="<YYYY-MM-DD> 23:59:59" --reverse --format="%h - %s%n%b%n---"`

3. **Retrieve Uncommitted/Investigatory Tasks**
   - Review the current conversation's transcript and memory to identify any tasks performed during the time window that did not result in a git commit (e.g., debugging sessions, architecture investigations, root-cause analysis, abandoned refactors).
   - Determine the approximate chronological placement of these uncommitted tasks relative to the git commits.

4. **Format and Present the Output**
   - Present the output as a single, unified numbered list in **strict chronological order** (oldest to newest).
   - **Do NOT group** the items into "Committed" vs "Uncommitted". Mix them chronologically as they occurred.
   - For committed tasks, use the format: `**[hash] - [Commit Title]**`
   - For uncommitted tasks, use the format: `**Uncommitted - [Task Type]: [Short Title]**` (e.g., `Investigation: Non-MCC Token Issue`).
   - Underneath the title, provide an italicized, concise human-readable summary of what the task actually accomplished or uncovered.
   - Example format:
     1. **`bfdab59d` - fix: resolve cut-off empty state UI**
        *(Refactored the Tanker Queue layout to use a CustomScrollView...)*
     2. **`Uncommitted` - Investigation: QA Discrepancy on "Reopen" Button**
        *(Analyzed QA rules regarding hiding the Reopen button for cancellations...)*

5. **Completion**
   - Output the finalized unified list directly to the user.
