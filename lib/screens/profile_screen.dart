import 'package:flutter/material.dart';
import 'package:todo_app/Customs/custom_form_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
              CustomFormField(controller: nameController, hintText: "Enter User Name", minLines: 1, max: 2),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Motivation Quote", style: TextStyle(color: Color(0xffFFFCFC),fontSize: 20)),
              ),
              CustomFormField(controller: motivationController, hintText: "Enter Motivation Quote ", minLines: 1, max: 2),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
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
    );;
  }
}
