import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CheckInDescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: 30,
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
