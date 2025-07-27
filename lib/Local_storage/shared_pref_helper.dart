import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/nav_screen.dart';
import '../screens/welcome_screen.dart';

class SharedPrefHelper {
  static Future<void> saveUserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
  }

  static Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirst = prefs.getBool('IsFirst') ?? true;

    if (isFirst) {
      await prefs.setBool('IsFirst', false);
    }

    return isFirst;
  }

  static Future<void> saveUserQuote(String userquote) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userquote', userquote);
  }

}