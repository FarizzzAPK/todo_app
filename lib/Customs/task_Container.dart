import 'package:flutter/material.dart';
import '../Models/task_model.dart';

class TaskContainer extends StatefulWidget {
  final TaskModel task;
  final VoidCallback? onChanged;
  final VoidCallback? onTaskDeleted; // New callback for deletion

  const TaskContainer({
    super.key,
    required this.task,
    this.onChanged,
    this.onTaskDeleted,
  });

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  late bool isDone;

  @override
  void initState() {
    super.initState();
    isDone = widget.task.isDone;

    if (isDone && !TaskModel.completedTasks.contains(widget.task)) {
      TaskModel.completedTasks.add(widget.task);
    }
  }

  void toggleDone() {
    setState(() {
      isDone = !isDone;
      widget.task.isDone = isDone;

      widget.onChanged?.call();
      TaskModel.saveTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff282828),
      ),
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
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xffA0A0A0)),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.edit, color: Colors.blue),
                        title: const Text('Edit Task'),
                        onTap: () {
                          Navigator.pop(context);
                          // TODO: Implement edit functionality
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete, color: Colors.red),
                        title: const Text('Delete Task'),
                        onTap: () async {
                          Navigator.pop(context);
                          bool deleted = await TaskModel.deleteTaskById(widget.task.id);
                          if (deleted) {
                            widget.onTaskDeleted?.call(); // Notify parent
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}