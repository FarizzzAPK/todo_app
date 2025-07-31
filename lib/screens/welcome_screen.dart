import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Local_storage/shared_pref_helper.dart';
import 'home_screen.dart';
import 'nav_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
TextEditingController nameController = TextEditingController();
   final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181818),
      appBar: AppBar(
        backgroundColor: Color(0xff181818),
        centerTitle: true,
        title: SvgPicture.asset('assets/app bar.svg'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome To Tasky",
                  style: TextStyle(
                      color: Color(0xffFFFCFC),
                      fontWeight: FontWeight.w400,
                      fontSize: 24),
                ),
                SizedBox(
                  width: 8,
                ),
                SvgPicture.asset('assets/handWave.svg',height: 32,width: 32,)
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your productivity journey starts here.",
                  style: TextStyle(
                      color: Color(0xffFFFCFC),
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: SvgPicture.asset(
                'assets/pana.svg',
                height: 205,
                width: 215,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Full Name",
                        style: TextStyle(
                            color: Color(0xffFFFCFC),
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ],
                  ),Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xff282828),
                          hintText: 'e.g. Faris Mahmoud',
                          hintStyle: TextStyle(
                              color: Color(0xff6D6D6D),
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                          errorStyle: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        style: TextStyle(
                            color: Color(0xffFFFCFC),
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 24,),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavScreen(),));
                          SharedPrefHelper.saveUserName(nameController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff15B86C),
                        foregroundColor: const Color(0xffFFFCFC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Text(
                        "Let’s Get Started",
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
          ],
        ),
      ),
    );
  }
}
