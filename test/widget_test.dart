import 'package:flutter_test/flutter_test.dart';
import 'package:pm_app/models/tasks.dart';
import 'package:pm_app/services/sla_service.dart';

ProjectTask _task(DateTime deadline, {String status = 'todo'}) => ProjectTask(
  title: 't',
  description: '',
  assigneeId: null,
  priority: 'Medium',
  deadline: deadline,
  status: status,
  createdAt: DateTime(2026, 1, 1),
);

void main() {
  final now = DateTime(2026, 6, 1, 12);

  test('SLA status follows the documented rule', () {
    expect(
      SlaService.calculate(
        _task(now.subtract(const Duration(hours: 1))),
        now: now,
      ),
      SlaStatus.overdue,
    );
    expect(
      SlaService.calculate(_task(now.add(const Duration(hours: 47))), now: now),
      SlaStatus.atRisk,
    );
    expect(
      SlaService.calculate(_task(now.add(const Duration(hours: 49))), now: now),
      SlaStatus.onTrack,
    );
    expect(
      SlaService.calculate(
        _task(now.subtract(const Duration(days: 3)), status: 'completed'),
        now: now,
      ),
      SlaStatus.completed,
    );
  });
}
