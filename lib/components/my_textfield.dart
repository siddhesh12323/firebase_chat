import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  const MyTextField(
      {super.key,
      required this.hintText,
      this.obscureText = false,
      required this.controller,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
        ),
      ),
    );
  }
}
