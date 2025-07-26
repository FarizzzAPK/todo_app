import 'package:flutter/material.dart';
import 'package:todo_app/Models/task_model.dart';

class CustomTaskCard extends StatefulWidget {
  const CustomTaskCard({super.key});

  @override
  State<CustomTaskCard> createState() => _CustomTaskCardState();
}

class _CustomTaskCardState extends State<CustomTaskCard> {
  bool isDone = false;
  late String taskName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Checkbox(
            value: isDone,
            onChanged: (value) {
              setState(() {
                isDone = value!;
              });
            },
            activeColor: const Color(0xff15B86C),
            checkColor: Colors.white,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isDone = !isDone;
              });
            },
            child: Text(
              TaskModel(taskName: taskName) as String,
              style: TextStyle(
                color: isDone ? Color(0xffA0A0A0) : Color(0xffFFFCFC),
                fontWeight: FontWeight.w500,
                fontSize: 16,
                decoration: isDone ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
