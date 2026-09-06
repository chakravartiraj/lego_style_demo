---
description: 
---

# Generate Zoho Sprint Task
This workflow generates a structured Zoho Sprint Task for a given requirement, ensuring semantic clarity and architectural alignment with project standards.

## Steps
1. **Analyze Requirement**: Identify the feature, refactor, or bug fix requested.
2. **Pattern Alignment**: Determine how the task affects existing architectures:
   - **API Layer**: Endpoint paths (e.g., specialized `/priority` or `/update-driver` routes), request/response payloads.
   - **Data Layer**: Models (Freezed/JSON), session persistence, and constant keys.
   - **Business Logic**: ViewModel subjects, streams, and repository methods.
   - **UI Layer**: Module-specific screens, standard composables, and reactive visibility.
3. **Draft Template**: Create the task content following this exact structure:
   - **Title**: [Module] > [Screen/Component]: [Action] [Specific Issue/Feature]. Make it highly specific and to the point so a developer immediately visualizes the exact part of the codebase affected (e.g., `Driver Module > Delivery Condfirmation Modal: Make image upload optional for MCC trips`).
   - **Description**: Context and technical rationale.
   - **Scope of Work (API/Backend)**: Specific technical requirements for the backend team.
   - **Scope of Work (Mobile App)**: File-by-file or layer-by-layer implementation details.
   - **Scope of Work (QA/Testing)**: Testing scope and validation strategy for QA:
     - **Prerequisites / Setup**: Specific roles/permissions (e.g., In-Charge, Manager), filling station configurations, or exact mock states required.
     - **Key Test Cases**: Specific functional scenarios, negative tests, and edge cases to execute.
     - **Regression & Impact Areas**: List of adjacent features or shared modules (e.g., shared lists or verification screens) that could be impacted by this change.
   - **Acceptance Criteria**: Bulleted list of validation points.
4. **Strict Output Rule**: Return **ONLY** the generated markdown template. Do **NOT** provide any conversational headers ("Here is the template..."), footers ("Hope this helps..."), or tips. The output must begin with the Title and end with the last Acceptance Criterion.
