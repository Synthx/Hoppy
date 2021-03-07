import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/data/data.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'add_beer_cubit.dart';
import 'add_beer_state.dart';

class AddBeerDialogFooter extends StatelessWidget {
  final FormGroup form;

  const AddBeerDialogFooter({
    required this.form,
  });

  void _addBeer(BuildContext context) {
    final value = form.value;
    final beer = Beer(
      name: value['name'],
      degree: value['degree'],
      color: value['color'],
      style: value['style'],
      country: value['country'],
      picturePath: value['picturePath'],
      title: value['title'],
      creationDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
    );
    context.read<AddBeerCubit>().addBeer(beer);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: BlocBuilder<AddBeerCubit, AddBeerState>(
          buildWhen: (prev, curr) => prev.loading != curr.loading,
          builder: (context, state) {
            return ReactiveFormConsumer(
              builder: (context, form, child) {
                return ElevatedButton(
                  onPressed: form.valid ? () => _addBeer(context) : null,
                  child: const Text('Ajouter'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
