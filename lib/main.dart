import 'package:firebase_chat/services/auth/auth_gate.dart';
import 'package:firebase_chat/firebase_options.dart';
import 'package:firebase_chat/themes/dark_mode.dart';
import 'package:firebase_chat/themes/light_mode.dart';
import 'package:firebase_chat/themes/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).getTheme,
    );
  }
}
