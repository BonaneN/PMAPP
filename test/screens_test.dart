import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pm_app/models/app_notification.dart';
import 'package:pm_app/models/tasks.dart';
import 'package:pm_app/models/team_member.dart';
import 'package:pm_app/screens/auth_screen.dart';
import 'package:pm_app/screens/dashboard_screen.dart';
import 'package:pm_app/screens/notifications_screen.dart';
import 'package:pm_app/screens/profile_screen.dart';
import 'package:pm_app/screens/task_details_screen.dart';
import 'package:pm_app/screens/task_form_screen.dart';
import 'package:pm_app/screens/tasks_screen.dart';
import 'package:pm_app/screens/team_screen.dart';
import 'package:pm_app/theme/apptheme.dart';
import 'package:pm_app/widgets/floating_nav_bar.dart';

const _me = TeamMember(
  id: 1,
  name: 'Amina Uwase',
  role: 'Project lead',
  email: 'amina@team.dev',
  initials: 'AU',
);

final _now = DateTime.now();
final _tasks = [
  ProjectTask(
    id: 1,
    title: 'Fix dashboard progress calculation with a rather long title that wraps',
    description: 'Handle the empty task list.',
    assigneeId: 1,
    priority: 'High',
    deadline: _now.subtract(const Duration(days: 1)),
    status: 'todo',
    createdAt: _now,
  ),
  ProjectTask(
    id: 2,
    title: 'Review form',
    description: '',
    assigneeId: 1,
    priority: 'Medium',
    deadline: _now.add(const Duration(days: 1)),
    status: 'inProgress',
    createdAt: _now,
  ),
  ProjectTask(
    id: 3,
    title: 'Palette',
    description: 'Done',
    assigneeId: null,
    priority: 'Low',
    deadline: _now.add(const Duration(days: 9)),
    status: 'completed',
    createdAt: _now,
  ),
];

Future<void> _show(WidgetTester tester, Widget screen, ThemeData theme) async {
  tester.view.physicalSize = const Size(360, 780);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(MaterialApp(theme: theme, home: screen));
  await tester.pump(const Duration(seconds: 2));
}

void main() {
  final screens = <String, Widget Function()>{
    'dashboard': () => Scaffold(
      body: DashboardScreen(
        tasks: _tasks,
        members: const [_me],
        onOpenTask: (_) {},
        onToggleTask: (_) {},
        onAddTask: () {},
        onShowTasks: (_) {},
      ),
    ),
    'tasks': () => Scaffold(
      body: TasksScreen(
        tasks: _tasks,
        members: const [_me],
        filter: 'All',
        onFilterChanged: (_) {},
        onOpenTask: (_) {},
        onToggleTask: (_) {},
        onAddTask: () {},
      ),
    ),
    'team': () => Scaffold(
      body: TeamScreen(
        members: const [_me],
        tasks: _tasks,
        onSave: (_) async {},
        onDelete: (_) async {},
      ),
    ),
    'profile': () => Scaffold(
      body: ProfileScreen(
        member: _me,
        onSignOut: () {},
        isDarkMode: true,
        onDarkModeChanged: (_) {},
        notificationsEnabled: false,
        onNotificationsChanged: (_) {},
        onOpenNotifications: () {},
      ),
    ),
    'details': () => TaskDetailsScreen(
      task: _tasks.first,
      members: const [_me],
      onEdit: (_) async => null,
      onUpdate: (_, _) async {},
      onDelete: (_) async {},
    ),
    'form': () => const TaskFormScreen(members: [_me]),
    'notifications': () => NotificationsScreen(
      notifications: ValueNotifier([
        AppNotification(
          id: 1,
          type: 'created',
          title: 'Task created',
          body: 'Amina created “Review form”.',
          taskId: 2,
          createdAt: _now,
        ),
      ]),
      tasks: _tasks,
      onOpenTask: (_) {},
      onMarkAllRead: () async {},
      onClear: () async {},
    ),
    'auth': () => AuthScreen(
      members: const [_me],
      onSignIn: (_) {},
      onRegister: (_, _, _) async {},
    ),
    'nav': () => Scaffold(
      bottomNavigationBar: FloatingNavBar(
        index: 1,
        onChanged: (_) {},
        onAdd: () {},
      ),
    ),
  };

  for (final theme in {
    'light': AppTheme.light,
    'dark': AppTheme.dark,
  }.entries) {
    for (final entry in screens.entries) {
      testWidgets('${entry.key} renders without overflow (${theme.key})', (
        tester,
      ) async {
        await _show(tester, entry.value(), theme.value);
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('auth creates an account for an unknown email', (tester) async {
    String? created;
    await _show(
      tester,
      AuthScreen(
        members: const [_me],
        onSignIn: (_) {},
        onRegister: (name, email, role) async => created = '$name|$email|$role',
      ),
      AppTheme.light,
    );
    await tester.enterText(find.byType(TextFormField), 'new@person.dev');
    await tester.tap(find.text('Continue'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text('Create your account'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).last, 'New Person');
    await tester.tap(find.text('Create account'));
    await tester.pump();
    expect(created, 'New Person|new@person.dev|Team member');
  });

  testWidgets('auth signs a registered email straight in', (tester) async {
    TeamMember? signedIn;
    await _show(
      tester,
      AuthScreen(
        members: const [_me],
        onSignIn: (m) => signedIn = m,
        onRegister: (_, _, _) async {},
      ),
      AppTheme.light,
    );
    await tester.enterText(find.byType(TextFormField), 'AMINA@team.dev');
    await tester.tap(find.text('Continue'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.textContaining('Welcome back, Amina'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    expect(signedIn?.id, 1);
  });
}
