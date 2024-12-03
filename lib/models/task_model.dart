// Task data type storing the title , due-data , completion state and storage flag
class Task {
  final String taskTitle;
  final String dueDate;
  bool? isCompleted;
  bool? api;

  Task({required this.taskTitle, required this.dueDate , this.isCompleted , this.api});

  // Task from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskTitle: json['TaskTitle'],
      dueDate: json['DueDate'],
      isCompleted: json['isCompleted'],
      api : json['api'],
    );
  }

  // JSON from Task
  Map<String, dynamic> toJson() {
    return {
      'TaskTitle': taskTitle,
      'DueDate': dueDate,
      'isCompleted' : isCompleted,
      'api' : api
    };
  }



}
