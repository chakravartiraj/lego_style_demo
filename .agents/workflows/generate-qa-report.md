# Generate QA Report

**STRICT RULE**: Return ONLY the structured report. NO introductory or closing conversational text.

## Steps

1. **Context Intake**: Identify the issue description provided by the user (e.g., "Manager module -> Assigned Tab list not showing").
2. **Technical Audit**:
   - Run `git log -n 5 --patch` or check the current unstaged/staged changes to identify the specific code modifications related to the issue.
   - Analyze the files involved to understand the **Root Cause** (why it was broken) and the **Solution** (how it was fixed).
3. **Drafting the Report**: Generate a response following this exact structure:
   - **Header**: "Professional QA Report: [Issue Title]"
   - **Root Cause Analysis**: A clear, non-technical explanation of why the bug occurred.
   - **Fix Implemented**: Technical details of the changes (e.g., "Updated ObservableObject refresh logic," "Corrected API mapping").
   - **Verification Steps**: A numbered list of clear instructions for QA to follow to prove the fix works (including edge cases if applicable).
4. **Final Review**: Ensure the language is professional, objective, and aligns with the project's terminology.
5. **Output**: Return ONLY the drafted report in your final response. Do NOT include any introductory text, closing remarks, or meta-commentary (e.g., "Here is the report"). The output must start directly with the header.
