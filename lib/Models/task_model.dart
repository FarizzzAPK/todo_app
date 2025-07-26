class TaskModel {
  String taskName;
  bool isDone;
  bool isPriority;

  TaskModel({
    required this.taskName,
    this.isPriority =false,
    this.isDone = false,
  });
}
