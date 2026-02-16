import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/habit_provider.dart';
import 'package:intl/intl.dart';

class AddHabitPage extends ConsumerStatefulWidget {
  const AddHabitPage({super.key});

  @override
  ConsumerState<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends ConsumerState<AddHabitPage> {
  final TextEditingController _habitController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  /// PICK DATE
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  /// PICK TIME
  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  /// SAVE HABIT
  void _saveHabit() async {
    final title = _habitController.text.trim();
    if (title.isEmpty || selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter name, date & time')),
      );
      return;
    }

    // Menambahkan habit lewat provider dengan named parameter
    final success = await ref.read(habitProvider.notifier).addHabitWithDateTime(
      title: title,
      date: selectedDate!,
      hour: selectedTime!.hour,
      minute: selectedTime!.minute,
    );

    if (success) {
      Navigator.pop(context); // kembali ke HomePage
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$title added!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Habit already exists')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Habit')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _habitController,
              decoration: const InputDecoration(
                labelText: 'Habit Name',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickDate,
              child: Text(
                selectedDate == null
                    ? 'Select Date'
                    : DateFormat.yMMMMd().format(selectedDate!),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _pickTime,
              child: Text(
                selectedTime == null
                    ? 'Select Time'
                    : selectedTime!.format(context),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveHabit,
              child: const Text('Save Habit'),
            ),
          ],
        ),
      ),
    );
  }
}