import '../entities/task.dart';
import '../repositories/task_repository.dart';

class AddTask {
  final TaskRepository repository;

  AddTask(this.repository);

  Future<void> call(Task task) async {
    if (task.title.isEmpty) {
      throw Exception("Title cannot be empty");
    }
    await repository.addTask(task);
  }
}
