import 'package:flutter/material.dart';
import 'package:todo_app/screens/completed_screen.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/profile_screen.dart';
import 'package:todo_app/screens/splash_screen.dart';
import 'package:todo_app/screens/to_do_screen.dart';

import 'Local_storage/shared_pref_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isDark = await SharedPrefHelper.getIsDarkMode();

  runApp( MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

