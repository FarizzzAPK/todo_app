import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/to_do_screen.dart';
import 'package:todo_app/screens/completed_screen.dart';
import 'package:todo_app/screens/profile_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<NavScreen> {
  int _selectedIndex = 0;

  final List<Widget> widgetOptions = [
    const HomeScreen(),
    ToDoScreen(),
    const CompletedScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Color getIconColor(int index) {
    return _selectedIndex == index ? const Color(0xff15B86C) : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181818),
      body: widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff181818),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xff15B86C),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: getIconColor(0)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/toDoIcon.svg",
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(getIconColor(1), BlendMode.srcIn),
            ),
            label: 'To DO',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/CompletedIcon.svg",
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(getIconColor(2), BlendMode.srcIn),
            ),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/profileIcon.svg",
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(getIconColor(3), BlendMode.srcIn),
            ),
            label: 'Profile',

          ),
        ],
      ),
    );
  }
}
