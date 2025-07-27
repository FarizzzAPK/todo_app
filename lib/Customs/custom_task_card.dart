import 'package:flutter/material.dart';
import '../Models/task_model.dart';

class CustomTaskCard extends StatefulWidget {
  final TaskModel task;
  final VoidCallback? onChanged;

  const CustomTaskCard({
    super.key,
    required this.task,
    this.onChanged,
  });

  @override
  State<CustomTaskCard> createState() => _CustomTaskCardState();
}

class _CustomTaskCardState extends State<CustomTaskCard> {
  late bool isDone;

  @override
  void initState() {
    super.initState();
    isDone = widget.task.isDone;

    if (isDone && !TaskModel.CompletedTask.contains(widget.task)) {
      TaskModel.CompletedTask.add(widget.task);
    }
  }

  void toggleDone() {
    setState(() {
      isDone = !isDone;
      widget.task.isDone = isDone;

      if (isDone) {
        if (!TaskModel.CompletedTask.contains(widget.task)) {
          TaskModel.CompletedTask.add(widget.task);
        }
        TaskModel.ToDoTask.remove(widget.task);
      } else {
        TaskModel.CompletedTask.remove(widget.task);
        if (!TaskModel.ToDoTask.contains(widget.task)) {
          TaskModel.ToDoTask.add(widget.task);
        }
      }
      widget.onChanged?.call();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
      child: Row(
        children: [
          Checkbox(
            value: isDone,
            onChanged: (value) => toggleDone(),
            activeColor: const Color(0xff15B86C),
            checkColor: Colors.white,
          ),
          Expanded(
            child: GestureDetector(
              onTap: toggleDone,
              child: Text(
                widget.task.taskName,
                style: TextStyle(
                  color: isDone ? const Color(0xffA0A0A0) : const Color(0xffFFFCFC),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  decoration: isDone ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ),
          if (widget.task.isPriority)
            const Icon(Icons.priority_high, color: Color(0xff15B86C), size: 20),
        ],
      ),
    );
  }
}
