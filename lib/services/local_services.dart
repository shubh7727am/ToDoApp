import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';

// local repo using sharedpref to store the task and their states
class TaskRepository {
  static const _tasksKey = 'tasks';

  Future<List<Task>> fetchTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getString(_tasksKey);


    if (tasksString != null) {
      final List<dynamic> tasksJson = json.decode(tasksString);
      return tasksJson.map((json) => Task.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((task) => task.toJson()).toList();
    await prefs.setString(_tasksKey, json.encode(tasksJson));
  }



}
