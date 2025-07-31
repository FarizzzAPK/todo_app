import 'package:flutter/material.dart';
import 'package:todo_app/Customs/custom_form_field.dart';
import 'package:todo_app/Models/task_model.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isSwitched = false;

  void addtask() {
    if (_formKey.currentState!.validate()) {
      final newTask = TaskModel(
        taskName: taskNameController.text.trim(),
        taskDescription: taskDescriptionController.text.trim(),
        isPriority: isSwitched,
      );

      TaskModel.allTasks.add(newTask);
      TaskModel.saveTasks();
      Navigator.pop(context, newTask);
    }
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181818),
      appBar: AppBar(
        backgroundColor: const Color(0xff181818),
        foregroundColor: const Color(0xffFFFCFC),
        title: const Text(
          "New Task",
          style: TextStyle(
            color: Color(0xffFFFCFC),
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 32, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  "Task Name",
                  style: TextStyle(
                    color: Color(0xffFFFCFC),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                CustomFormField(
                  max: 1,
                  controller: taskNameController,
                  hintText: "Enter Task Name",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter task name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  "Task Description",
                  style: TextStyle(
                    color: Color(0xffFFFCFC),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                CustomFormField(
                  max: 4,
                  controller: taskDescriptionController,
                  hintText: "Enter Task Description",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter task description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "High Priority ",
                      style: TextStyle(
                        color: Color(0xffFFFCFC),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                      activeColor: Color(0xffFFFCFC),
                      activeTrackColor: Color(0xff15B86C),
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.grey[700],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: addtask,
                      style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff15B86C),
                      foregroundColor: const Color(0xffFFFCFC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      "Add Task",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
