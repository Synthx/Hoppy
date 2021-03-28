import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/screens/new_check_in/new_check_in.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CheckInDateSelector extends StatefulWidget {
  final FormGroup form;

  const CheckInDateSelector({
    required this.form,
  });

  @override
  State createState() => _CheckInDateSelectorState();
}

class _CheckInDateSelectorState extends State<CheckInDateSelector> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.form.control('date').value ?? DateTime.now();
  }

  void _onDateChanged(DateTime date) {
    widget.form.control('date').value = date;
    setState(() {
      _selectedDate = date;
    });
  }

  void _openDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => DatePickerPopup(
        initialDate: _selectedDate,
        onDateChanged: (date) => _onDateChanged(date),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      textColor: Theme.of(context).textTheme.bodyText1!.color,
      iconColor: Theme.of(context).textTheme.bodyText1!.color,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: 10,
      ),
      child: ListTile(
        onTap: () => _openDatePicker(),
        title: const Text('Date *'),
        subtitle: Text(Localization.of(context).date(_selectedDate)),
        isThreeLine: false,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
