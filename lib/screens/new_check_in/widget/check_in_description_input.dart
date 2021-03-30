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
            'Commentaire',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                ),
          ),
          const SizedBox(height: 10),
          ReactiveTextField(
            formControlName: 'comment',
            maxLines: 4,
            showErrors: (_) => false,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: 'Laissez un commentaire sur votre bière',
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
