import 'package:flutter_test/flutter_test.dart';
import 'package:teste_unit/features/task/domain/entities/task.dart';

void main() {
  group('Add Task ', () {
    test('instantiate a task', () {
      final task = Task(id: '1', title: 'Test Task');

      expect(task.id, '1');
      expect(task.title, 'Test Task');
      expect(task.isCompleted, false);
    });
  });
}
