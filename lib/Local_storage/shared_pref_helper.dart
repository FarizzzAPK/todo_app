import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static Future<void> saveUserName(String name) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', name);
    } catch (e) {
      debugPrint('Error saving username: $e');
    }
  }

  static Future<bool> isFirstTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isFirst = prefs.getBool('isFirst') ?? true;
      if (isFirst) {
        await prefs.setBool('isFirst', false);
      }
      return isFirst;
    } catch (e) {
      debugPrint('Error checking first-time status: $e');
      return true;
    }
  }

  static Future<void> saveUserQuote(String userQuote) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userQuote', userQuote);
    } catch (e) {
      debugPrint('Error saving user quote: $e');
    }
  }

  static Future<void> saveIsDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  static Future<bool> getIsDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode') ?? false; // false = الوضع الفاتح
  }
}