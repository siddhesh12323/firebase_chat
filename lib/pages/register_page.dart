import 'package:firebase_chat/components/my_dialog.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  // email and password controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  // signup function
  void signup(BuildContext context) {
    // auth service
    AuthService _auth = AuthService();

    // signup with email and password
    if (_passwordController.text != _confirmpasswordController.text) {
      showDialog(
          context: context,
          builder: (context) {
            return const MyDialog(
                title: "Error!",
                content: "Please enter same password in both fields!");
          });
    } else {
      try {
        _auth.registerWithEmailAndPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) {
              return MyDialog(title: "Sign up failed!", content: " $e");
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(Icons.message,
                size: 70, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 20),
            // welcome back message
            Text(
              'Create an account',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
            const SizedBox(height: 20),
            // email textfield
            MyTextField(hintText: "Email", controller: _emailController),
            const SizedBox(height: 10),
            // password textfield
            MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: _passwordController),
            const SizedBox(height: 10),
            // confirm password textfield
            MyTextField(
                hintText: "Confirm Password",
                obscureText: true,
                controller: _confirmpasswordController),
            const SizedBox(height: 20),
            // login button
            MyButton(
              text: "Sign Up",
              onTap: () {
                signup(context);
              },
            ),
            const SizedBox(height: 20),
            // register button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
