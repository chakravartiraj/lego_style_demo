---
description: List out all the tasks committed on a specified date or time.
---

1. **Determine Reporting Date/Time Window**
   - Parse the user's requested date or time (e.g., "29 Jul 2026").
   - Define the start and end of that window. For a full date, use `00:00:00` to `23:59:59`.

2. **Retrieve Commit History**
   - Run the git command to fetch commits for that window:
     `git log --since="<YYYY-MM-DD> 00:00:00" --until="<YYYY-MM-DD> 23:59:59" --oneline`

3. **Format and Present the Output**
   - Provide an introductory sentence, e.g., "Here are the tasks (commits) that were made on [Date]:"
   - Present the output as an ordered list.
   - For each commit, display the short hash and the main commit title in bold.
   - Underneath the title, provide an italicized, concise human-readable summary of what the commit actually accomplished, using context from the commit body or recent conversation.
   - Example format:
     1. **`bfdab59d` - Fix tanker registration pre-filling and API integration**
        *(Added missing fields to the `OwnerTankerDetail` model and updated the BLoC mapping logic)*

4. **Completion**
   - Output the finalized list to the user directly (without asking further questions unless the date is ambiguous).
