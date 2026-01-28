import 'package:flutter/material.dart';
import '../routes.dart';


class HomePage2 extends StatelessWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBDBDBD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              /// progress bar
              LinearProgressIndicator(
                value: 0.6,
                backgroundColor: Colors.grey.shade300,
                valueColor:
                const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),

              const SizedBox(height: 24),

              /// title
              const Text(
                "When you wanna us remind you?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              /// reminder boxes (SAMA SEPERTI HOME_PAGE)
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: const [
                    ReminderBox(
                      time: "07:00",
                      label: "Morning",
                    ),
                    ReminderBox(
                      time: "13:00",
                      label: "Noon",
                    ),
                    ReminderBox(
                      time: "19:00",
                      label: "Evening",
                      isWide: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// bottom buttons (STYLE SAMA HOME_PAGE)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: BorderSide.none,
                        padding:
                        const EdgeInsets.symmetric(vertical: 14),
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
                        padding:
                        const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.homeSplashPage,
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
          ),
        ),
      ),
    );
  }
}

/// =======================
/// Reminder Box (STYLE SAMA HabitCard)
/// =======================
class ReminderBox extends StatelessWidget {
  final String time;
  final String label;
  final bool isWide;

  const ReminderBox({
    super.key,
    required this.time,
    required this.label,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isWide ? double.infinity : null,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}