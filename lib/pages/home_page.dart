import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../routes.dart';
import '../providers/habit_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitState = ref.watch(habitProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFBDBDBD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: habitState.when(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (e, _) => Center(
              child: Text(e.toString()),
            ),
            data: (habits) {
              final total = habits.length;
              final completed = habits.where((h) => h.isCompleted).length;
              final progress = total == 0 ? 0.0 : completed / total;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  /// PROGRESS
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey.shade300,
                    valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$completed of $total completed",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "What habit you want to do?",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Select One or More",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 24),

                  /// GRID OF HABITS
                  Expanded(
                    child: habits.isEmpty
                        ? const Center(
                      child: Text(
                        "No habits yet 🥲\nStart by selecting one below!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                        : GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.1,
                      children: habitsGrid(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide.none,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.homeSplashPage,
                            );
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.homePage2,
                            );
                          },
                          child: const Text(
                            "Proceed",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// =======================
  /// SHOW ADD HABIT DIALOG
  /// =======================
  Future<void> _showAddHabitDialog(
      BuildContext context, WidgetRef ref, String habitName) async {
    final TextEditingController controller =
    TextEditingController(text: habitName);
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    await showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text("Add Habit"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(hintText: "Habit name"),
              ),
              const SizedBox(height: 12),
              ListTile(
                title: Text(selectedDate == null
                    ? "Select date"
                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) setState(() => selectedDate = date);
                },
              ),
              ListTile(
                title: Text(selectedTime == null
                    ? "Select time"
                    : selectedTime!.format(context)),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) setState(() => selectedTime = time);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.isEmpty ||
                    selectedDate == null ||
                    selectedTime == null) return;

                final success = await ref
                    .read(habitProvider.notifier)
                    .addHabitWithDateTime(
                  title: controller.text.trim(),
                  date: selectedDate!,
                  hour: selectedTime!.hour,
                  minute: selectedTime!.minute,
                );

                if (success) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${controller.text} added!")),
                  );
                }
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  /// =======================
  /// GRID HABIT CARDS
  /// =======================
  List<Widget> habitsGrid() {
    const habitCards = [
      HabitCard(icon: Icons.camera_alt_outlined, label: "Take Picture"),
      HabitCard(icon: Icons.fitness_center, label: "Workout"),
      HabitCard(icon: Icons.edit_outlined, label: "Journaling"),
      HabitCard(icon: Icons.calendar_month_outlined, label: "Planning"),
      HabitCard(icon: Icons.sports_esports_outlined, label: "Game Tracking"),
      HabitCard(icon: Icons.menu_book_outlined, label: "Reading"),
      HabitCard(icon: Icons.music_note_outlined, label: "Music time"),
      HabitCard(icon: Icons.bedtime_outlined, label: "Sleep Early"),
    ];
    return habitCards;
  }
}

/// =======================
/// HABIT CARD WIDGET
/// =======================
class HabitCard extends ConsumerWidget {
  final IconData icon;
  final String label;

  const HabitCard({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitState = ref.watch(habitProvider);

    final isAlreadyAdded = habitState.maybeWhen(
      data: (habits) =>
          habits.any((h) => h.title.toLowerCase() == label.toLowerCase()),
      orElse: () => false,
    );

    return GestureDetector(
      onTap: isAlreadyAdded
          ? null
          : () {
        HomePage()._showAddHabitDialog(context, ref, label);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isAlreadyAdded ? Colors.grey.shade300 : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: isAlreadyAdded ? Colors.grey : Colors.black,
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isAlreadyAdded ? Colors.grey : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}