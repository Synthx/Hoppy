import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/add_beer/add_beer.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
    );
    context.read<AddBeerCubit>().addBeer(beer);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).cardColor,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: 10,
        ),
        child: ReactiveFormConsumer(
          builder: (context, form, child) {
            return Container(
              height: kFooterButtonHeight,
              child: ElevatedButton(
                onPressed: form.valid ? () => _addBeer(context) : null,
                child: const Text('Ajouter'),
              ),
            );
          },
        ),
      ),
    );
  }
}
