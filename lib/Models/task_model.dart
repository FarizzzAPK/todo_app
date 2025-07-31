import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskModel {
  final String id;
  final String _taskName;
  final String _taskDescription;
  bool _isDone;
  bool _isPriority;

  TaskModel({
    String? id,
    required String taskName,
    required String taskDescription,
    bool isDone = false,
    bool isPriority = false,
  })  : id = id ?? DateTime.now().microsecondsSinceEpoch.toString(),
        _taskName = taskName,
        _taskDescription = taskDescription,
        _isDone = isDone,
        _isPriority = isPriority;

  String get taskName => _taskName;
  String get taskDescription => _taskDescription;
  bool get isDone => _isDone;
  bool get isPriority => _isPriority;

  set isDone(bool value) => _isDone = value;
  set isPriority(bool value) => _isPriority = value;

  Map<String, dynamic> toJson() => {
    'id': id,
    'taskName': _taskName,
    'taskDescription': _taskDescription,
    'isDone': _isDone,
    'isPriority': _isPriority,
  };

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json['id'] as String,
    taskName: json['taskName'] as String,
    taskDescription: json['taskDescription'] as String,
    isDone: json['isDone'] as bool,
    isPriority: json['isPriority'] as bool,
  );

  static List<TaskModel> allTasks = [];
  static List<TaskModel> get toDoTasks =>
      allTasks.where((task) => !task.isDone).toList();
  static List<TaskModel> get completedTasks =>
      allTasks.where((task) => task.isDone).toList();
  static List<TaskModel> get priorityTasks =>
      allTasks.where((task) => task.isPriority).toList();
  static List<TaskModel> get nonPriorityTasks =>
      allTasks.where((task) => !task.isPriority).toList();

  static Future<void> saveTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson =
      allTasks.map((task) => jsonEncode(task.toJson())).toList();
      await prefs.setStringList('allTasks', tasksJson);
    } catch (e) {
      debugPrint('Error saving tasks: \$e');
    }
  }

  static Future<void> loadTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = prefs.getStringList('allTasks');
      if (tasksJson != null) {
        allTasks = tasksJson
            .map((json) =>
            TaskModel.fromJson(jsonDecode(json) as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('Error loading tasks: \$e');
    }
  }

  static Future<bool> deleteTaskById(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tasksJson = prefs.getStringList('allTasks');

      if (tasksJson != null) {
        List<TaskModel> tasks = tasksJson
            .map((json) => TaskModel.fromJson(jsonDecode(json)))
            .toList();

        tasks.removeWhere((task) => task.id == id);

        final updatedJsonList =
        tasks.map((task) => jsonEncode(task.toJson())).toList();
        await prefs.setStringList('allTasks', updatedJsonList);
        allTasks = tasks;
        priorityTasks.removeWhere((task) => task.id == id);
        nonPriorityTasks.removeWhere((task) => task.id == id);
        completedTasks.removeWhere((task) => task.id == id);
        return true; // Deletion successful
      }
      return false; // No tasks found
    } catch (e) {
      debugPrint('Error deleting task by id: $e');
      return false; // Deletion failed
    }
  }

}