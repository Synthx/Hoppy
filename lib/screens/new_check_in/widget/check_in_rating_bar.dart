import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CheckInRatingBar extends ReactiveFormField<double> {
  final String formControlName;

  CheckInRatingBar({
    required this.formControlName,
  }) : super(
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<double> field) {
            return RatingBar.builder(
              initialRating: field.value,
              onRatingUpdate: (value) => field.didChange(value),
              minRating: 1,
              maxRating: 5,
              allowHalfRating: true,
              direction: Axis.horizontal,
              itemBuilder: (context, _) {
                return Icon(
                  Icons.star,
                  color: Theme.of(context).primaryColor,
                );
              },
            );
          },
        );

  @override
  ReactiveFormFieldState<double> createState() =>
      ReactiveFormFieldState<double>();
}
