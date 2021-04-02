import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool checked;
  final Function(bool) onChanged;

  const CustomCheckbox({
    required this.checked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!checked),
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: checked ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: checked
                ? Theme.of(context).primaryColor
                : Theme.of(context).backgroundColor,
          ),
        ),
        child: Center(
          child: checked
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
  }
}
