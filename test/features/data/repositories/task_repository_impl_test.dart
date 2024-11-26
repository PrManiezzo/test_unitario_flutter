import 'package:flutter_test/flutter_test.dart';
import 'package:teste_unit/features/task/data/repositories/task_repository_impl.dart';
import 'package:teste_unit/features/task/domain/entities/task.dart';

void main() {
  late TaskRepositoryImpl repository;

  setUp(() {
    repository = TaskRepositoryImpl();
  });

  test("Should add and retrieve tasks", () async {
    final task = Task(id: "1", title: "Test Task");

    await repository.addTask(task);

    final tasks = await repository.getTasks();
    expect(tasks, contains(task));
  });

  test("Should delete a task", () async {
    final task = Task(id: "1", title: "Test Task");

    await repository.addTask(task);
    await repository.deleteTask(task.id);

    final tasks = await repository.getTasks();
    expect(tasks, isNot(contains(task)));
  });
}
