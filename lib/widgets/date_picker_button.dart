import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerButton extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onPressed;

  const DatePickerButton({Key? key, required this.selectedDate, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        selectedDate == null ? 'Select Date' : DateFormat.yMMMMd().format(selectedDate!),
      ),
    );
  }
}