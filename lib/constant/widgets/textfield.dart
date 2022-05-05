// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  String hint;
  bool obscure;
  MyTextField({this.controller, this.hint, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black),
      autofocus: false,
      decoration: InputDecoration(
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 212, 0, 0)),
          ),
          hintStyle:
              TextStyle(color: Color(0xFF5B0000), ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 243, 243, 243)),
      controller: controller,
      obscureText: obscure,
    );
  }
}
