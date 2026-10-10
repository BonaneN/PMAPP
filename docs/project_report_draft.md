# SprintMate — Project Report

> **Before submission:** replace every bracketed placeholder, confirm whether the course expects this summary and the technical report as separate PDFs, add the real GitHub and contribution-tracker links, and export this report to PDF within the three-page limit.

## Project and team

**Course:** [Course name]  
**Group:** [Group name]  
**Members:** [Names of all four members]  
**GitHub repository:** [Repository URL]  
**Contribution tracker:** [Shared tracker URL]  
**Demo recording:** [Video URL]

## Purpose and application

SprintMate is a Flutter mobile application for a small software team to organize project work, assign responsibility, set deadlines, and identify tasks that need attention. It includes user selection, a project dashboard, searchable and filterable tasks, task details, a create/edit form, team-member management, a profile view, and a project statistics screen.

The task workflow is designed to be demonstrated from end to end: select a team profile, create a task, assign a teammate and deadline, view its details and SLA label, update its status, and see the dashboard totals respond. Team members can be added, edited, and removed. Removing a member leaves their existing tasks unassigned rather than deleting the work.

## Technical and design decisions

The app is a frontend project and does not connect to a backend. It uses SQLite on the device through the `sqflite` package. Tasks and members are stored in local tables; task/member objects are mapped to database rows by the storage service. The database is created in the platform’s private application-data directory, so runtime records are not checked into Git.

The UI uses a shared Material theme and a bottom navigation bar for Home, Tasks, Team, and Profile. The dashboard calculates its totals from the current task collection. A shared SLA service applies the same rule across dashboard, list, statistics, and detail views: Completed takes precedence; otherwise a past deadline is Overdue; a deadline within 48 hours is At Risk; all other incomplete tasks are On Track.

Forms validate required task titles, assignments, member names, and email addresses, and provide user-facing validation feedback. User selection is a local demonstration flow and is not real authentication.

## Collaboration and challenges

The team divided ownership across foundation/dashboard, people/profile, task browsing, and task form/documentation. The shared task/member models and storage/SLA services provide common interfaces for those areas. Use the contribution tracker and repository history to report each member’s actual work; do not infer contributions from this draft.

The main design challenge was keeping task data consistent across forms, task views, and dashboard statistics. The app routes writes through a shared SQLite storage service and refreshes the app’s task collection after changes. Another challenge was keeping SLA results consistent across screens; this was addressed by putting the 48-hour rule in one service instead of repeating deadline checks in each widget. [Add any additional challenges your group actually encountered and how you resolved them.]

## Device verification and reflection

**Device/emulator tested:** [Device and OS]  
**Date tested:** [Date]  
**Workflow verified:** [Record what the group actually tested, including persistence after restart, validation, task updates, and SLA examples.]  
**Known limitations or remaining issues:** [List accurately, or write “None identified during the recorded checks.”]

Do not fill this section until the team has run the app on a physical mobile device or emulator and confirmed the listed behavior.

## AI Usage Declaration

AI assistance was used to help plan and draft parts of the Flutter application, including the data models, SQLite storage layer, SLA logic, UI screens, and supporting documentation. The submitted team is responsible for reviewing, running, adapting, and understanding all AI-assisted material. Before submission, the group should replace this declaration if its use of AI differed, record the team’s actual verification and modifications, and make sure every member can explain their contribution and the code they present.
