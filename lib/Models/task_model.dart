class TaskModel {
  String taskName;
  bool isDone;
  bool isPriority;
  String taskDescription;

  TaskModel({
    required this.taskName,
    required this.taskDescription,

    this.isPriority =false,
    this.isDone = false,
  });

  static List<TaskModel> ToDoTask = [
  ];
  static List<TaskModel> CompletedTask = [
  ];
  static List<TaskModel> PriorityTask = [
  ];
  static List<TaskModel> allTasks = [
  ];
}
