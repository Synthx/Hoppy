import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CheckInDescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                ),
          ),
          const SizedBox(height: 10),
          ReactiveTextField(
            formControlName: 'description',
            maxLines: 4,
            showErrors: (_) => false,
            decoration: InputDecoration(
              hintText: 'Laissez une note',
              hintStyle: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
