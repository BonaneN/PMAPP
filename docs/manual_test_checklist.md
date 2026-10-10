# SprintMate manual test checklist

Run these checks on an Android/iOS emulator or physical device. Mark **Pass/Fail** only after trying the action on the running app. Record device/OS and any failure details so the team can reproduce and fix issues.

**Device/emulator:** [fill in]  
**OS/version:** [fill in]  
**Tester/date:** [fill in]

| Check | Steps | Expected result | Result / notes |
|---|---|---|---|
| First launch | Install/run the app with no existing app data. | SprintMate opens to user selection and has sample team/tasks for demonstration. | [ ] |
| User selection | Tap a team member, then switch user from Profile. | Selected profile opens the dashboard; switch returns to user selection. | [ ] |
| Dashboard | Review totals and progress on the first launch. | Counts and progress match the displayed task data; empty state does not divide by zero. | [ ] |
| Create form validation | Open New task and submit with a blank title. | Form shows a title validation message and does not save. | [ ] |
| Create a task | Enter a valid title, description, assignee, priority, and deadline; save. | Form closes and the new task appears in the task list and dashboard counts. | [ ] |
| Search/filter | Search by task title or assignee; try status and SLA filters. | Only matching tasks appear; clearing search/filter restores the list. | [ ] |
| Details/edit | Open a task, edit fields, save, then return to details/list. | Updated values and assignee appear consistently. | [ ] |
| SLA — Completed | Mark a task complete, including one whose deadline has passed. | Its SLA label is Completed. | [ ] |
| SLA — Overdue | Create/edit an incomplete task with a past deadline. | Its SLA label is Overdue. | [ ] |
| SLA — At Risk | Create/edit an incomplete task due within 48 hours. | Its SLA label is At Risk. | [ ] |
| SLA — On Track | Create/edit an incomplete task due more than 48 hours from now. | Its SLA label is On Track. | [ ] |
| Team CRUD | Add a member, edit their name/role/email, then remove them. | Validation works; changes display; tasks assigned to a removed member remain and become unassigned. | [ ] |
| Last member guard | Try to remove the only remaining member. | The app keeps one member and explains why the last profile cannot be removed. | [ ] |
| Persistence | Create/update a task and member, fully close the app, and relaunch it. | Changes remain after relaunch. | [ ] |
| Narrow screen/layout | Repeat dashboard, list, and form checks on a smaller phone/emulator size; scroll long screens. | No overflow; content remains reachable by scrolling. | [ ] |
| Delete task | Delete a task from details and confirm. | Task disappears from list/dashboard; canceling the confirmation leaves it intact. | [ ] |

## Record defects clearly

For every failure, note the screen, exact steps, expected/actual result, device/OS, and whether it happens again after relaunch. Fix and re-run the failed row before recording the final demo. Do not put unverified claims in either report.
