import 'package:flutter/material.dart';

class MyAddTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool multiline;

  const MyAddTextField({super.key, required this.controller, required this.hintText, required this.multiline});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: multiline ? 7 : 1,
      keyboardType: multiline ? TextInputType.multiline : null,
      style: TextStyle(color: Colors.grey.shade300),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500),
        ),
        fillColor: Colors.grey.shade800,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
      ),
    );
  }
}
