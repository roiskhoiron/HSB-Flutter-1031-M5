import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';

class UserPage extends ConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(themeProvider);
    final isDarkMode = currentMode == ThemeMode.dark;

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
                  ref
                      .read(themeProvider.notifier)
                      .setTheme(
                    val
                        ? ThemeMode.dark
                        : ThemeMode.light,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}