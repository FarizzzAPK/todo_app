import 'package:flutter/material.dart';
import '../Customs/custom_task_card.dart';
import '../Customs/task_Container.dart';
import '../Models/task_model.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<CompletedScreen> {
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
              child: Text("Completed Tasks", style: TextStyle(color: Colors.white,fontSize: 24)),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TaskModel.completedTasks.isEmpty
                  ? Center(child: Text("لا توجد مهام مكتملة", style: TextStyle(color: Colors.white)))
                  : ListView.builder(
                itemCount: TaskModel.completedTasks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TaskContainer(
                      task: TaskModel.completedTasks[index],
                      onChanged: () => setState(() {}),
                    ),
                  );
                },
              )

            ),
          ],
        ),
      ),
    );
  }
}
