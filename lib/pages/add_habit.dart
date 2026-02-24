import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/habit_provider.dart';
import '../widgets/habit_text_field.dart';
import '../widgets/date_picker_button.dart';
import '../widgets/time_picker_button.dart';
import '../widgets/save_habit_button.dart';

class AddHabitPage extends ConsumerStatefulWidget {
  const AddHabitPage({super.key});

  @override
  ConsumerState<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends ConsumerState<AddHabitPage> {
  final TextEditingController _habitController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (date != null) setState(() => selectedDate = date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) setState(() => selectedTime = time);
  }

  void _saveHabit() async {
    final title = _habitController.text.trim();
    if (title.isEmpty || selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter name, date & time')),
      );
      return;
    }

    final success = await ref.read(habitProvider.notifier).addHabitWithDateTime(
      title: title,
      date: selectedDate!,
      hour: selectedTime!.hour,
      minute: selectedTime!.minute,
    );

    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$title added!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Habit already exists')));
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
            HabitTextField(controller: _habitController),
            const SizedBox(height: 16),
            DatePickerButton(selectedDate: selectedDate, onPressed: _pickDate),
            const SizedBox(height: 8),
            TimePickerButton(selectedTime: selectedTime, onPressed: _pickTime),
            const SizedBox(height: 30),
            SaveHabitButton(onPressed: _saveHabit),
          ],
        ),
      ),
    );
  }
}