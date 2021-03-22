import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hoppy/core/core.dart';
import 'package:reactive_forms/reactive_forms.dart';

class BeerDegreeInput extends StatelessWidget {
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
            'Degré *',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                ),
          ),
          ReactiveTextField(
            formControlName: 'degree',
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText2!.color,
            ),
          ),
        ],
      ),
    );
  }
}
