import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';
import '../../data/repositories/task_repository_impl.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TaskRepositoryImpl repository = TaskRepositoryImpl();
  final TextEditingController _taskController = TextEditingController();
  List<Task> tasks = [];

  Future<void> _addTask() async {
    if (_taskController.text.isNotEmpty) {
      final task = Task(
        id: DateTime.now().toString(),
        title: _taskController.text,
      );
      await repository.addTask(task);
      _loadTasks();
      _taskController.clear();
    }
  }

  Future<void> _toggleTask(Task task) async {
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      isCompleted: !task.isCompleted,
    );
    await repository.updateTask(updatedTask);
    _loadTasks();
  }

  Future<void> _deleteTask(String id) async {
    await repository.deleteTask(id);
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    tasks = await repository.getTasks();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: "Task Title",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addTask,
            child: const Text("Add Task"),
          ),
          Expanded(
            child: tasks.isEmpty
                ? const Center(child: Text("No tasks available"))
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return ListTile(
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: task.isCompleted,
                              onChanged: (_) => _toggleTask(task),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteTask(task.id),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
