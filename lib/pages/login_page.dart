import 'package:firebase_chat/components/my_button.dart';
import 'package:firebase_chat/components/my_dialog.dart';
import 'package:firebase_chat/components/my_textfield.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  // email and password controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // login function
  void login(BuildContext context) async {
    // auth service
    AuthService _auth = AuthService();

    // login with email and password
    try {
      await _auth.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return MyDialog(title: "Log in failed!", content: " $e");
          });
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
              'Welcome Back!',
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
            const SizedBox(height: 20),
            // login button
            MyButton(
              text: "Login",
              onTap: () {
                login(context);
              },
            ),
            const SizedBox(height: 20),
            // register button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Sign Up",
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
