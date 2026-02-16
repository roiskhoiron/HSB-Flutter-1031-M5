import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/habit_provider.dart';
import 'habit_card.dart';

class HabitGrid extends ConsumerWidget {
  final void Function(BuildContext context, WidgetRef ref, String habitName) onAddHabit;

  const HabitGrid({super.key, required this.onAddHabit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitState = ref.watch(habitProvider);

    return habitState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (habits) {
        final habitCards = [
          {'icon': Icons.camera_alt_outlined, 'label': 'Take Picture'},
          {'icon': Icons.fitness_center, 'label': 'Workout'},
          {'icon': Icons.edit_outlined, 'label': 'Journaling'},
          {'icon': Icons.calendar_month_outlined, 'label': 'Planning'},
          {'icon': Icons.sports_esports_outlined, 'label': 'Game Tracking'},
          {'icon': Icons.menu_book_outlined, 'label': 'Reading'},
          {'icon': Icons.music_note_outlined, 'label': 'Music time'},
          {'icon': Icons.bedtime_outlined, 'label': 'Sleep Early'},
        ];

        return GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: habitCards.map((e) {
            final label = e['label'] as String;
            final icon = e['icon'] as IconData;
            final isAdded = habits.any((h) => h.title.toLowerCase() == label.toLowerCase());

            return HabitCard(
              icon: icon,
              label: label,
              isAlreadyAdded: isAdded,
              onTap: () => onAddHabit(context, ref, label),
            );
          }).toList(),
        );
      },
    );
  }
}