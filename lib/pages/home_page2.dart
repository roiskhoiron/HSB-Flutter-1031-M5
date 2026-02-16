import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/habit_provider.dart';
import '../routes.dart';

class HomePage2 extends ConsumerWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitState = ref.watch(habitProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFBDBDBD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: habitState.when(
            loading: () =>
            const Center(child: CircularProgressIndicator()),
            error: (e, _) =>
                Center(child: Text(e.toString())),
            data: (habits) {
              final total = habits.length;
              final completed =
                  habits.where((h) => h.isCompleted).length;
              final progress =
              total == 0 ? 0.0 : completed / total;

              return Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  /// PROGRESS BAR
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor:
                    Colors.grey.shade300,
                    valueColor:
                    const AlwaysStoppedAnimation(
                        Colors.blue),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "$completed of $total completed",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Your Habits",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// LIST HABITS
                  Expanded(
                    child: habits.isEmpty
                        ? const Center(
                      child: Text(
                        "No habits yet 🥲",
                        textAlign:
                        TextAlign.center,
                      ),
                    )
                        : ListView.builder(
                      itemCount: habits.length,
                      itemBuilder:
                          (context, index) {
                        final habit =
                        habits[index];

                        return Container(
                          margin:
                          const EdgeInsets
                              .only(
                              bottom:
                              12),
                          decoration:
                          BoxDecoration(
                            color:
                            Colors.white,
                            borderRadius:
                            BorderRadius
                                .circular(
                                12),
                          ),
                          child: ListTile(
                            leading:
                            Checkbox(
                              value: habit
                                  .isCompleted,
                              onChanged: (_) {
                                ref
                                    .read(
                                    habitProvider
                                        .notifier)
                                    .toggleHabit(
                                    habit.id);
                              },
                            ),
                            title: Text(
                              habit.title,
                              style:
                              TextStyle(
                                decoration: habit
                                    .isCompleted
                                    ? TextDecoration
                                    .lineThrough
                                    : null,
                              ),
                            ),
                            trailing:
                            IconButton(
                              icon:
                              const Icon(
                                  Icons
                                      .delete),
                              onPressed:
                                  () {
                                ref
                                    .read(
                                    habitProvider
                                        .notifier)
                                    .deleteHabit(
                                    habit.id);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// BACK BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors.black,
                        padding:
                        const EdgeInsets
                            .symmetric(
                            vertical:
                            14),
                      ),
                      onPressed: () {
                        Navigator
                            .pushReplacementNamed(
                          context,
                          AppRoutes
                              .homeSplashPage,
                        );
                      },
                      child: const Text(
                        "Finish",
                        style: TextStyle(
                            color:
                            Colors.white),
                      ),
                    ),
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
}