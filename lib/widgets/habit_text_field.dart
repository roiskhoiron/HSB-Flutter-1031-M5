import 'package:flutter/material.dart';

class HabitTextField extends StatelessWidget {
  final TextEditingController controller;

  const HabitTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Habit Name',
      ),
    );
  }
}