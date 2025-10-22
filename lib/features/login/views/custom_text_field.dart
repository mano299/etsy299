import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this.controller,
    this.validator,
    required this.hint,
    required this.label,
    required this.icon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hint;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.lightGreen,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintFadeDuration: Duration(milliseconds: 600),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.greenAccent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        label: Text(
          hint,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        hintText: label,
        hintStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
      ),
    );
  }
}
