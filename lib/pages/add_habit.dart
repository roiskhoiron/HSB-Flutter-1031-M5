import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({super.key});

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  final TextEditingController _habitController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void dispose() {
    _habitController.dispose();
    super.dispose();
  }

  /// ===== DATE PICKER =====
  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  /// ===== TIME PICKER MANUAL =====
  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (time != null) {
      setState(() => selectedTime = time);
    }
  }

  /// ===== QUICK TIME =====
  void _setQuickTime(TimeOfDay time) {
    setState(() => selectedTime = time);
  }

  void _addHabit() {
    if (_habitController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter habit name')),
      );
      return;
    }

    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date & time')),
      );
      return;
    }

    Navigator.pop(context, {
      'name': _habitController.text.trim(),
      'date': selectedDate,
      'time': selectedTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ===== HEADER =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Add New Habbit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.person_outline),
                ],
              ),

              const SizedBox(height: 30),

              /// ===== HABIT NAME =====
              const Text('Habbit Name'),
              TextField(
                controller: _habitController,
                decoration: const InputDecoration(
                  hintText: 'Enter habit',
                  border: UnderlineInputBorder(),
                ),
              ),

              const SizedBox(height: 24),

              /// ===== DATE PICKER =====
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null
                          ? 'Select date'
                          : DateFormat.yMMMMd().format(selectedDate!),
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: _pickDate,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// ===== TIME PICKER MANUAL =====
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedTime == null
                          ? 'Select time'
                          : selectedTime!.format(context),
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: _pickTime,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// ===== QUICK TIME =====
              const Text(
                'When we should remind you ?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ReminderButton(
                    label: 'Morning',
                    isActive:
                    selectedTime == const TimeOfDay(hour: 7, minute: 0),
                    onTap: () =>
                        _setQuickTime(const TimeOfDay(hour: 7, minute: 0)),
                  ),
                  _ReminderButton(
                    label: 'Noon',
                    isActive:
                    selectedTime == const TimeOfDay(hour: 13, minute: 0),
                    onTap: () =>
                        _setQuickTime(const TimeOfDay(hour: 13, minute: 0)),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Center(
                child: _ReminderButton(
                  label: 'Evening',
                  isActive:
                  selectedTime == const TimeOfDay(hour: 19, minute: 0),
                  onTap: () =>
                      _setQuickTime(const TimeOfDay(hour: 19, minute: 0)),
                ),
              ),

              const Spacer(),

              /// ===== ADD BUTTON =====
              ElevatedButton(
                onPressed: _addHabit,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  backgroundColor: Colors.black,
                ),
                child: const Text('Add Habit'),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// ===== BUTTON =====
class _ReminderButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ReminderButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? Colors.green : Colors.green.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}