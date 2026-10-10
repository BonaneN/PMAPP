# SprintMate — Technical Report

> **Submission preparation:** This is a draft for the 2–4 page technical report. Replace bracketed fields, add any real issues discovered during testing, and export to PDF after the group has verified the app. The bibliography below uses Flutter and package documentation.

## 1. Architecture and project structure

SprintMate separates presentation, data models, and persistence. `lib/models/tasks.dart` defines the task data used by the form, task list, details, and dashboard. `lib/models/team_member.dart` defines the people who can be selected as assignees. `lib/services/storage.dart` owns SQLite setup and CRUD operations. `lib/services/sla_service.dart` owns the task deadline rule. Screen widgets are under `lib/screens/`, while `lib/theme/apptheme.dart` provides shared visual styling.

The app shell in `lib/screens/home.dart` loads the local task/member collections and passes them to screens. User actions return changes to the shell, which writes through the storage service and reloads the shared data. The dashboard derives its totals from that collection, avoiding independent hard-coded counters. Local UI choices such as the selected tab and search filter use `setState`, which asks Flutter to rebuild the affected widget when its state changes [1].

Navigation uses a bottom `NavigationBar` for the main areas and `Navigator` with `MaterialPageRoute` for the task form, task details, and statistics. This supports the project’s simple mobile navigation flow without adding a routing package [2].

## 2. Local persistence

The assignment does not require a server, so the app uses SQLite locally through `sqflite`. The database is opened in the platform’s application-data directory. It contains a `members` table, a `tasks` table, and a small metadata table used to ensure the starter demonstration records are seeded once. The task table stores the title, description, assignee ID, priority, deadline, completion status, and creation time. A foreign-key rule sets the assignee to null if a member is deleted, preserving the task.

The storage service exposes load/save/delete operations; screen widgets do not issue SQL queries directly. The Flutter persistence cookbook documents SQLite as an option for structured persistent data, and `sqflite` supplies the Flutter SQLite plugin used by this project [3][4]. Runtime database files stay on the device and are excluded from Git.

## 3. SLA and task logic

`SlaService.calculate` is the single source for task SLA classification. It applies these rules in order:

1. A completed task is **Completed**.
2. An incomplete task with a deadline before the current time is **Overdue**.
3. An incomplete task due within the next 48 hours is **At Risk**.
4. All other incomplete tasks are **On Track**.

The ordering matters: completion takes precedence over an old deadline. The same service is used for task badges, dashboard counts, and statistics so that one task cannot be shown as Overdue in one screen and Completed in another. The 48-hour threshold is a project decision and should be explained during the demonstration.

## 4. Forms, feedback, and navigation

The task form uses a `Form` with a `GlobalKey<FormState>` and field validators. A blank or too-short title, missing assignee, or excessively long description is rejected with a field-level message. The date picker sets the task deadline; dropdowns capture priority, assignee, and (when editing) task status. Member creation/editing validates the name and basic email format. Flutter’s form guidance uses the same `Form`, `TextFormField`, and validator approach [5].

Database load failures produce a retry screen. Save/update/delete failures show a message through a `SnackBar`. User selection is intentionally local and is not real authentication, as permitted by the assignment.

## 5. Challenges and decisions

The first integration risk was that each screen could maintain a different task list. Shared models plus a single storage service and parent-managed app data were selected to keep screens consistent. A second risk was duplicated deadline logic; isolating the SLA rule in a service keeps it reusable and explainable. The database seeds a small demonstration dataset once so the initial dashboard can show Completed, At Risk, Overdue, and On Track examples. The group should test the empty-list state and create its own tasks as well.

**Additional challenge observed during group testing:** [Describe the actual failure or difficulty.]  
**Resolution and evidence:** [Describe the fix and how it was verified. Do not claim a test that was not performed.]

## 6. Verification and limitations

**Device/emulator and OS:** [Fill after testing]  
**Build/run result:** [Fill after testing]  
**Persistence check:** [Close/reopen app and record result]  
**Validation and SLA scenarios:** [Record actual cases tried]  
**Known limitations:** [For example, user selection is a demo flow, not server authentication. Add other observed limitations.]

The current repository also contains Flutter’s original counter widget-test template, which is no longer aligned with the app. Replace or remove that starter test as a team task before relying on the test suite. The app’s source files should be reviewed and the app run on a mobile emulator/device before submission.

## AI Usage Declaration

AI tools assisted with planning and drafting parts of the app and documentation. The team must review and verify those changes, make any needed modifications, and be able to explain the submitted implementation. Update this statement to match exactly how the group used AI and identify which AI-assisted portions were reviewed and tested.

## References

[1] Flutter, “Add interactivity to your Flutter app,” https://docs.flutter.dev/ui/interactivity.  
[2] Flutter, “Navigation and routing,” https://docs.flutter.dev/ui/navigation.  
[3] Flutter, “Persistence cookbook,” https://docs.flutter.dev/cookbook/persistence.  
[4] Flutter package, “sqflite,” https://pub.dev/packages/sqflite.  
[5] Flutter, “Build a form with validation,” https://docs.flutter.dev/cookbook/forms/validation.
