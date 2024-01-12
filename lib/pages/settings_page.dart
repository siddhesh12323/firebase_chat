import 'package:firebase_chat/themes/dark_mode.dart';
import 'package:firebase_chat/themes/light_mode.dart';
import 'package:firebase_chat/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .setTheme(lightMode);
                  },
                  child: const Text("Light Mode"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .setTheme(darkMode);
                  },
                  child: const Text("Dark Mode"),
                ),
              ],
            ),
          ],
        ));
  }
}
