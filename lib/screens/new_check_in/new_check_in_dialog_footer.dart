import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/data/data.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'new_check_in_cubit.dart';
import 'new_check_in_state.dart';
import 'widget/check_in_rating_bar.dart';

class NewCheckInDialogFooter extends StatelessWidget {
  final FormGroup form;
  final Beer beer;

  const NewCheckInDialogFooter({
    required this.form,
    required this.beer,
  });

  void _addCheckIn(BuildContext context) {
    final value = form.value;
    final checkIn = CheckIn(
      rating: value['rating'],
      date: value['date'],
      servingStyle: value['servingStyle'],
      description: value['description'],
      location: value['location'],
      beer: beer,
    );
    context.read<NewCheckInCubit>().addCheckIn(checkIn);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckInRatingBar(
              formControlName: 'rating',
            ),
            const SizedBox(height: 10),
            Container(
              height: 60,
              width: double.infinity,
              child: BlocBuilder<NewCheckInCubit, NewCheckInState>(
                buildWhen: (prev, curr) => prev.loading != curr.loading,
                builder: (context, state) {
                  return ReactiveFormConsumer(
                    builder: (context, form, child) {
                      return ElevatedButton(
                        onPressed:
                            form.valid ? () => _addCheckIn(context) : null,
                        child: const Text('Enregistrer'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
