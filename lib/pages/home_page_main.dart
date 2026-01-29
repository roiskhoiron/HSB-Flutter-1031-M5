import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mission_5_habbits/pages/home_page.dart';
import 'package:mission_5_habbits/pages/user_page.dart';
import 'add_habit.dart';

class HomePageMain extends StatefulWidget {
  const HomePageMain({super.key});

  @override
  State<HomePageMain> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> habits = [];

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }

    if (index == 1) {
      final newHabit = await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddHabitPage()),
      );

      if (newHabit != null && newHabit is Map<String, dynamic>) {
        setState(() {
          habits.add(newHabit);
        });
      }
    }

    if (index == 2) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const UserPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              /// ===== HEADER =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        const TextSpan(
                          text: 'Today,\n',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextSpan(
                          text: DateFormat('MMMM d').format(now),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.person_outline, size: 28),
                ],
              ),

              const SizedBox(height: 24),

              /// ===== WEEK CALENDAR =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) {
                  final day =
                  startOfWeek.add(Duration(days: index));
                  final isToday =
                      day.day == now.day && day.month == now.month;

                  return Column(
                    children: [
                      Text(
                        DateFormat('E').format(day)[0],
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 34,
                        height: 34,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isToday
                              ? Colors.black
                              : Colors.grey.shade400,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                            color:
                            isToday ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),

              const SizedBox(height: 32),

              /// ===== MY HABIT =====
              const Text(
                'My Habbit',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              /// ===== HABIT LIST =====
              Expanded(
                child: habits.isEmpty
                    ? const Center(
                  child: Text(
                    'No habits yet',
                    style: TextStyle(color: Colors.black54),
                  ),
                )
                    : ListView.separated(
                  itemCount: habits.length,
                  separatorBuilder: (_, __) =>
                      Divider(color: Colors.grey.shade500),
                  itemBuilder: (context, index) {
                    final habit = habits[index];

                    String subtitle = '';
                    if (habit['time'] is TimeOfDay) {
                      subtitle =
                      'Completed at ${habit['time'].format(context)}';
                    }

                    return Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            habit['name'] ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      /// ===== BOTTOM NAV =====
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
      ),
    );
  }
}