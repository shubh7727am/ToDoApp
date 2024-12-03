import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task_model.dart';
import '../services/local_services.dart';

// provider for local task
final taskRepositoryProvider = Provider((ref) => TaskRepository());

final taskListProvider = StateNotifierProvider<TaskListViewModel, List<Task>>(
      (ref) => TaskListViewModel(ref.read(taskRepositoryProvider)),
);

class TaskListViewModel extends StateNotifier<List<Task>> {
  final TaskRepository _repository;

  TaskListViewModel(this._repository) : super([]) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await _repository.fetchTasks();
    state = tasks;
  }

  Future<void> addTask(String title , String dueDate , bool isStoreLocally) async {
    final newTask = Task( dueDate: dueDate, taskTitle: title , isCompleted: false , api: isStoreLocally);
    state = [...state, newTask];

    await _repository.saveTasks(state);



  }

  Future<void> toggleTaskCompletion(String title) async {
    state = state.map((task) {
      if (task.taskTitle == title) {
        return Task(dueDate: task.dueDate, taskTitle: task.taskTitle, isCompleted: true);
      }
      return task;
    }).toList();
    await _repository.saveTasks(state);
  }

  Future<void> deleteTask(String title) async {
    state = state.where((task) => task.taskTitle != title).toList();
    await _repository.saveTasks(state);
  }
}
