import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;

  const Footer({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Habitly',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Jl. Bebas No. 123, Jakarta',
            style: TextStyle(fontSize: 12),
          ),
          const Text(
            '0812-3456-7890 • Habitly Company',
            style: TextStyle(fontSize: 12),
          ),
          const Text(
            'Community • Owner Creator',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 12),

          // INPUT HABIT
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Nama Habit',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),

          // BUTTON SIMPAN
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSave,
              child: const Text('Simpan'),
            ),
          ),
        ],
      ),
    );
  }
}