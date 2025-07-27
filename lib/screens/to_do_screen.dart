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
      appBar: AppBar(
        leadingWidth: 35,
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff181818),
        title: Text("To Do List", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            Expanded(
              child: TaskModel.ToDoTask.isEmpty
                  ? Center(
                      child: Text("لا توجد مهام",
                          style: TextStyle(color: Colors.white)))
                  : ListView.builder(
                      itemCount: TaskModel.ToDoTask.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TaskContainer(
                            task: TaskModel.ToDoTask[index],
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
