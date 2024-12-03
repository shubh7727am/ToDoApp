import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/task_model.dart';
import '../services/services.dart';


// Task Service Provider for operations with our restfulApi from github
final taskServiceProvider = Provider((ref) => TaskService());

// ViewModel
class TaskViewModel extends StateNotifier<List<Task>> {
  final TaskService _taskService;
  bool isLoading = false;

  TaskViewModel(this._taskService) : super([]){
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    isLoading = true;
    try {
      final tasks = await _taskService.fetchTasks();
      state = tasks;
    } catch (e) {
      log("ERROR $e");
    }
    finally {
      isLoading = false; // Set loading to false
    }
  }
  Future<void> toggleTaskCompletion(String title) async {
    state = state.map((task) {
      if (task.taskTitle == title) {
        return Task(dueDate: task.dueDate, taskTitle: task.taskTitle, isCompleted: true , api: true);
      }
      return task;
    }).toList();
    await _taskService.updateUserData("db", {"Tasks" : state});
  }

  Future<void> deleteTask(String title) async {
    // Filter the state to exclude the task with the given title
    state = state.where((task) => task.taskTitle != title).toList();

    // Update the database with the modified state
    try {
      await _taskService.updateUserData("db", {"Tasks": state});
    } catch (e) {
      // Handle potential errors in updating user data
      log("Error updating user data: $e");
      return;
    }


  }


  Future<void> addTask(String title , String dueDate , bool isStoreLocally) async {
    final newTask = Task( dueDate: dueDate, taskTitle: title , isCompleted: false , api: isStoreLocally);
    state = await _taskService.fetchTasks();
    state = [...state, newTask];
    _taskService.updateUserData("db", {"Tasks" : state});


  }






}


// Post ViewModel Provider
final taskViewModelProvider = StateNotifierProvider<TaskViewModel, List<Task>>(
      (ref) => TaskViewModel(ref.read(taskServiceProvider)),
);
