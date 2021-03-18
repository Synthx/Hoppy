import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatePickerPopup extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime) onDateChanged;

  const DatePickerPopup({
    required this.initialDate,
    required this.onDateChanged,
  });

  @override
  _DatePickerPopupState createState() => _DatePickerPopupState();
}

class _DatePickerPopupState extends State<DatePickerPopup> {
  void _onDateChanged(DateTime date) {
    widget.onDateChanged(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: CupertinoDatePicker(
        initialDateTime: widget.initialDate,
        maximumDate: DateTime.now(),
        onDateTimeChanged: (value) => _onDateChanged(value),
        mode: CupertinoDatePickerMode.date,
        use24hFormat: true,
      ),
    );
  }
}
