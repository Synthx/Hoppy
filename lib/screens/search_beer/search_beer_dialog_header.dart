import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/widget/form/search_input.dart';

class SearchBeerDialogHeader extends StatelessWidget {
  final Function(String?) onValueChanged;
  final Function(bool)? onFocused;

  const SearchBeerDialogHeader({
    required this.onValueChanged,
    this.onFocused,
  });

  void _closeDialog(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => _closeDialog(context),
        ),
        Flexible(
          child: SearchInput(
            onValueChanged: onValueChanged,
            onFocused: onFocused,
          ),
        ),
      ],
    );
  }
}
