import 'package:flutter/material.dart';
import 'package:todo_app/Local_storage/shared_pref_helper.dart';

import '../Customs/custom_form_field.dart';
class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  TextEditingController motivationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> _formKey =GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Color(0xff181818),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text("User Details", style: TextStyle(color: Colors.white,fontSize: 20)),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("User Name", style: TextStyle(color: Color(0xffFFFCFC),fontSize: 20)),
                ),
                CustomFormField(controller: nameController, hintText: "Enter User Name", max: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Motivation Quote", style: TextStyle(color: Color(0xffFFFCFC),fontSize: 20)),
                ),
                CustomFormField(controller: motivationController, hintText: "Enter Motivation Quote ", max: 4),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        SharedPrefHelper.saveUserName(nameController.text);
                        SharedPrefHelper.saveUserQuote(motivationController.text);
                        Navigator.pop(context);
                        setState(() {
            
                        });
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
                      "Save Changes",
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
    );;
  }

}
