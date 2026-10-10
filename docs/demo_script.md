# SprintMate demo outline (10–15 minutes)

Use this as a rehearsal guide, not a word-for-word script. Replace the member labels with your names. Each person should explain code they personally reviewed and understand. Record the running app on an Android/iOS emulator or physical phone, then show selected source files where useful.

## Before recording

- Confirm the app opens on a mobile emulator or physical device.
- Use the initial sample tasks to demonstrate On Track, At Risk, Overdue, and Completed. Create one new task during the recording as well.
- Have the GitHub repository, branches/pull requests, contribution tracker, and report links ready to show.
- If sample tasks were previously changed, use the app’s create/edit flow to set up the statuses you intend to demonstrate.
- Do not claim an action worked unless you have tried it on the recorded build.

## Run of show

| Time | Presenter | Show and explain |
|---|---|---|
| 0:00–0:45 | A / coordinator | Introduce the group, the problem SprintMate addresses, and the project scope. State that it is a local-first Flutter app without backend authentication. |
| 0:45–2:00 | B | Show user selection. Explain that selecting a team profile demonstrates the required user flow and is not real authentication. Move to Team and show member roles/profile fields. |
| 2:00–4:00 | D | Open Create Task. Submit an empty title to show validation, then create a task with an assignee, priority, description, and deadline. Explain the relevant form fields and validation. |
| 4:00–6:30 | C | Find the new task in the task list. Demonstrate search and a status filter, open details, and explain the shared SLA badge. Show examples for an upcoming task, an at-risk task, an overdue task, and a completed task. |
| 6:30–7:30 | C | Open project statistics and explain that counts come from the same task data. Return to the dashboard and show that the totals/progress reflect the current tasks. |
| 7:30–8:30 | A | Mark a task complete and show the dashboard/SLA response. Briefly explain the 48-hour At Risk rule and why Completed is checked first. |
| 8:30–9:30 | A | Close and reopen the app, then show that saved tasks and members remain. State what device/emulator was used and only report the persistence result if verified. |
| 9:30–11:30 | A | Show `ProjectTask`, `StorageService`, and `SlaService`. Explain task fields, SQLite tables/CRUD, state refresh, and that dashboard totals are derived rather than hard-coded. |
| 11:30–12:30 | B | Show the team-member form/CRUD code and profile/user-selection screens. Explain the validations and how task assignees refer to member IDs. |
| 12:30–13:30 | C | Show task search/filter/details or statistics code. Explain the relevant layout/widgets and how task screens use the common SLA service. |
| 13:30–14:30 | D | Show task-form code and explain title/assignee validation, dropdowns, deadline picker, and error feedback. Summarize report/documentation work and honestly disclose AI assistance. |
| 14:30–15:00 | All | Each member states one contribution and one implementation detail they learned. Close with the repository and contribution-tracker links. |

## If time is limited

Keep the complete user workflow and all four members’ explanations. Trim repeated UI descriptions before trimming the create/update/persistence/SLA demonstration or the source-code walkthrough, because the brief asks the group to demonstrate both functionality and technical understanding.
