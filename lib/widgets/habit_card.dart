import 'package:flutter/material.dart';

class HabitCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isAlreadyAdded;
  final VoidCallback? onTap;

  const HabitCard({
    super.key,
    required this.icon,
    required this.label,
    required this.isAlreadyAdded,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isAlreadyAdded ? null : onTap,
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