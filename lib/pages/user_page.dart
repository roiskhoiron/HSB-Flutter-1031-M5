import 'package:flutter/material.dart';
import '../main.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool get isDarkMode => themeNotifier.value == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),

          /// DARK MODE SWITCH
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).cardColor,
            ),
            child: ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('Dark Mode'),
              subtitle: const Text('Enable dark theme'),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (val) {
                  themeNotifier.value =
                  val ? ThemeMode.dark : ThemeMode.light;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}