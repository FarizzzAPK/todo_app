import 'package:flutter/material.dart';
import '../Customs/custom_task_card.dart';
import '../Customs/task_Container.dart';
import '../Models/task_model.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181818),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24,
        ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("To Do List", style: TextStyle(color: Colors.white,fontSize: 24)),
          ),
            Expanded(
              child: TaskModel.toDoTasks.isEmpty
                  ? Center(
                      child: Text("لا توجد مهام",
                          style: TextStyle(color: Colors.white)))
                  : ListView.builder(
                      itemCount: TaskModel.toDoTasks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TaskContainer(
                            task: TaskModel.toDoTasks[index],
                            onChanged: () => setState(() {}),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
