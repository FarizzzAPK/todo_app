import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final double minLines;
  final double max;


  const CustomFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    required this.minLines,
    required this.max,

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      minLines: 3, // 👈 أقل عدد سطور
      maxLines: null, // 👈 بيكبر حسب المحتوى
      style: const TextStyle(
        color: Color(0xffFFFCFC),
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        filled: true,
        fillColor: const Color(0xff282828),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xff6D6D6D),
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xff15B86C), width: 1.5),
        ),
      ),
    );
  }
}
