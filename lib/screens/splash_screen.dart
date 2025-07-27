import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/screens/nav_screen.dart';
import 'package:todo_app/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkIfFirstTime();
  }

  Future<void> _checkIfFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirst = prefs.getBool('IsFirst') ?? true;

    // لو أول مرة، نعرض Welcome ونخزن إنه مش أول مرة
    if (isFirst) {
      await prefs.setBool('IsFirst', false);
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>  WelcomeScreen()),
        );
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const NavScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width =MediaQuery.of(context).size.width;
    return SafeArea(
      child: SizedBox(
        height: height,
        width: width,
        child: SvgPicture.asset('assets/Splash.svg', fit: BoxFit.cover),
      ),
    );
  }
}
