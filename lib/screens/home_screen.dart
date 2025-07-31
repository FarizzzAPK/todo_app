import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Customs/custom_task_card.dart';
import 'package:todo_app/Customs/task_Container.dart';
import 'package:todo_app/screens/add_new_task_screen.dart';
import '../Models/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  String? motivationQuote;

  @override
  void initState() {
    super.initState();
    getUserMotivationQuote();
    getUsernameFromPrefs();
    loadTasksFromPrefs();
  }

  Future<void> loadTasksFromPrefs() async {
    await TaskModel.loadTasks();
    setState(() {});
  }

  Future<void> getUserMotivationQuote() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      motivationQuote = prefs.getString('userQuote');
    });
  }

  Future<void> getUsernameFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });
  }

  Future<void> _goToAddTask() async {
    final TaskModel? newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddNewTaskScreen()),
    );
    if (newTask != null) {
      setState(() {});
    }
  }

  void _onTaskDeleted() {
    setState(() {}); // Refresh UI after deletion
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff181818),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/Faris.jpg"),
                    radius: 30,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Evening, $username",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          motivationQuote ?? "One task at a time. One step closer.",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xffC6C6C6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff282828),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.light_mode_sharp,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [Column(
                    children: [
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          const Text(
                            "Yuhuu, Your work Is",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 32,
                              color: Color(0xffFFFCFC),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "almost done!",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 32,
                              color: Color(0xffFFFCFC),
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/handWave.svg',
                            height: 32,
                            width: 32,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xff282828),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Achieved Tasks",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 24,
                                    color: Color(0xffFFFCFC),
                                  ),
                                ),
                                Text(
                                  "${TaskModel.completedTasks.length} Out of ${TaskModel.allTasks.length} Done",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color(0xffC6C6C6),
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 48,
                                  width: 48,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.transparent,
                                    value: TaskModel.allTasks.isEmpty
                                        ? 0
                                        : (TaskModel.completedTasks.length / TaskModel.allTasks.length),
                                    color: const Color(0xff15B86C),
                                  ),
                                ),
                                Text(
                                  TaskModel.allTasks.isEmpty
                                      ? "0%"
                                      : "${((TaskModel.completedTasks.length / TaskModel.allTasks.length) * 100).toStringAsFixed(0)}%",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xffC6C6C6),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff282828),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0, left: 16),
                              child: Text(
                                "High Priority Tasks",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xff15B86C),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ListView.builder(
                              itemCount: TaskModel.priorityTasks.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return CustomTaskCard(
                                  key: ValueKey(TaskModel.priorityTasks[index].id),
                                  task: TaskModel.priorityTasks[index],
                                  onChanged: () {
                                    setState(() {});
                                    TaskModel.saveTasks();
                                  },
                                  onTaskDeleted: _onTaskDeleted, // Pass deletion callback
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "My Tasks",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffC6C6C6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        itemCount: TaskModel.nonPriorityTasks.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TaskContainer(
                              key: ValueKey(TaskModel.nonPriorityTasks[index].id),
                              task: TaskModel.nonPriorityTasks[index],
                              onChanged: () {
                                setState(() {});
                                TaskModel.saveTasks();
                              },
                              onTaskDeleted: _onTaskDeleted, // Pass deletion callback
                            ),
                          );
                        },
                      ),
                    ],
                  ),],
                ),
              )


            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: FloatingActionButton.extended(
            backgroundColor: const Color(0xff15B86C),
            onPressed: _goToAddTask,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              "Add New Task",
              style: TextStyle(color: Colors.white),
            ),
            tooltip: 'Add New Task',
          ),
        ),
      ),
    );
  }
}