import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Customs/custom_form_field.dart';
import 'package:todo_app/Local_storage/shared_pref_helper.dart';
import 'package:todo_app/screens/user_details_screen.dart';

import '../Customs/custom_row.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username;
  String? motivationQuote;
  bool isDark = true;


  @override
  void initState() {super.initState();
   getUserMotivationQuote()    ;
 getUsernameFromPrefs();
  loadIsDarkMode(); // ضيف دي

 }
  Future<void> loadIsDarkMode() async {
    final value = await SharedPrefHelper.getIsDarkMode();
    setState(() {
      isDark = value;
    });
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff181818),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text("My Profile", style: TextStyle(color: Color(0xffFFFCFC),fontSize: 24)),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.center,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/Faris.jpg"),
                    radius: 50,
                  ),
                ),
            
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text("$username", style: TextStyle(color: Color(0xffFFFCFC),fontSize: 20)),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text("$motivationQuote", style: TextStyle(color: Color(0xffC6C6C6),fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text("Profile Info", style: TextStyle(color: Color(0xffFFFCFC),fontSize: 24)),
                ), SizedBox(
                  height: 16,
                ),
                CustomRow(
                  icon: Icons.settings,
                  text: "User Details",
                  onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsScreen(),));                },
                ),
                Divider(
                  color: Color(0xffCAC4D0),
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.dark_mode_outlined, color: Color(0xffFFFCFC),size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                        "Dark Mode",
                      style: const TextStyle(color: Color(0xffFFFCFC), fontSize: 16),
                    ),
                  ),
                  Switch(
                    value: isDark,
                    onChanged: (value) async {
                      setState(() {
                        isDark = value;
                      });
                      await SharedPrefHelper.saveIsDarkMode(value);
                    },
                    activeColor: Color(0xffFFFCFC),
                    activeTrackColor: Color(0xff15B86C),
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey[700],
                  ),
                ],
              ),
            ),
                 Divider(
                  color: Color(0xffCAC4D0),
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                ),
                CustomRow(
                  icon: Icons.logout_outlined,
                  text: "Log Out",
                  onTap: () {
                    print("Tapped Settings");
                  },
                ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }

}
