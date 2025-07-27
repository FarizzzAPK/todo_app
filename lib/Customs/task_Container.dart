import 'package:flutter/material.dart';
import 'package:todo_app/Customs/custom_task_card.dart';
import 'package:todo_app/Models/task_model.dart';

class TaskContainer extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onChanged; // صحح النوع هنا كمان

  TaskContainer({
    super.key,
    required this.task,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xff282828),
      ),
      child: CustomTaskCard(
        task: task,
        onChanged: onChanged,
      ),
    );
  }
}
