---
description: Generates a dev comment for a given Git commit ID, developer notes, or last conversation message that is understandable for technical and non-technical staff, including QA testing instructions.
---

# Generate Dev Comment for Commit
This workflow inspects a specific change context and generates a structured developer comment that translates code changes into clear functional updates, accompanied by a QA scoping plan.

## Steps
1. **Context Intake**: Identify the source of information for the changes:
   - **Git Commit ID**: If a commit ID is provided, run `git show <commit_id>` to view the commit message and the code diff.
   - **Manual Dev Details**: If raw details or bullet points are provided directly by the developer, parse them to understand the changes.
   - **Last Conversation Response**: If asked to use the last response, audit the preceding message, any recent code modifications, or files touched in that step.
2. **Analyze Changes**:
   - **Non-Technical Perspective**: What functional problem was solved? What does the user see or experience differently?
   - **Technical Perspective**: Which layers (UI, BLoC, Repository, Models, API) were changed? Identify the exact files modified.
   - **QA Scoping**: What setup, test cases, and regression areas are relevant to these modifications?
3. **Draft Template**: Create the comment following this exact structure:
   - **Title**: `Dev Comment: [Brief Summary of the Change]`
   - **Functional Overview**: A clear, non-technical description of what the change does and why it was implemented.
   - **Technical Changes**: A concise list of code changes (e.g., modified methods, endpoints, validation changes) with links to the relevant files.
   - **Scope of Work (QA/Testing)**: Testing scope and validation strategy for QA:
     - **Prerequisites / Setup**: Specific roles/permissions (e.g., In-Charge, Manager, Driver), filling station configurations, or exact mock states/database states required.
     - **Key Test Cases**: Specific functional scenarios (happy path), negative tests, and edge cases to execute.
     - **Regression & Impact Areas**: List of adjacent features or shared modules (e.g., shared lists, common widgets) that could be impacted by this change.
4. **Strict Output Rule**: Return **ONLY** the generated dev comment in your final response. Do **NOT** include any introductory headers ("Here is the comment..."), closing notes, or meta-commentary. The output must start directly with the Title and end with the last item in the Regression section.
