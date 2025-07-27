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
  }

  Future<void> getUserMotivationQuote() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      motivationQuote = prefs.getString('userquote');
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
      MaterialPageRoute(builder: (_) => AddNewTaskScreen()),
    );
    if (newTask != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff181818),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/Faris.jpg"),
                    radius: 30,
                  ),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Evening, $username",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(motivationQuote ?? "One task at a time. One step closer.",

        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff282828),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.light_mode_sharp,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                "Yuhuu, Your work Is",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 32,
                  color: Color(0xffFFFCFC),
                ),
              ),
              Row(
                children: [
                  Text(
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
                  )
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xff282828),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Achieved Tasks",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: Color(0xffFFFCFC),
                          ),
                        ),
                        Text(
                          "${TaskModel.allTasks.length} Out of ${TaskModel.CompletedTask.length} Done",
                          style: TextStyle(
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
                                : (TaskModel.CompletedTask.length / TaskModel.allTasks.length),
                            color: Color(0xff15B86C),
                          ),
                        ),
                        Text(
                          TaskModel.allTasks.isEmpty
                              ? "0%"
                              : "${((TaskModel.CompletedTask.length / TaskModel.allTasks.length) * 100).toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffC6C6C6),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xff282828),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "High Priority Tasks",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xff15B86C),
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      itemCount: TaskModel.PriorityTask.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CustomTaskCard(
                          task: TaskModel.PriorityTask[index],
                          onChanged: () {
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "My Tasks",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffC6C6C6),
                ),
              ),
              SizedBox(height: 8),
              ListView.builder(
                itemCount: TaskModel.allTasks.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TaskContainer(
                      task: TaskModel.allTasks[index],
                      onChanged: () {
                        setState(() {});
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
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
    );
  }
}
