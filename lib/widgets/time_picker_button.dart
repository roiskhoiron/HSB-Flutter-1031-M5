import 'package:flutter/material.dart';

class TimePickerButton extends StatelessWidget {
  final TimeOfDay? selectedTime;
  final VoidCallback onPressed;

  const TimePickerButton({Key? key, required this.selectedTime, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        selectedTime == null ? 'Select Time' : selectedTime!.format(context),
      ),
    );
  }
}