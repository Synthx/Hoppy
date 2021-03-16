import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/edit_beer/edit_beer.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditBeerDialogFooter extends StatelessWidget {
  final FormGroup form;

  const EditBeerDialogFooter({
    required this.form,
  });

  void _editBeer(BuildContext context) {
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
    context.read<EditBeerCubit>().edit(beer);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
                onPressed: form.valid ? () => _editBeer(context) : null,
                child: const Text('Modifier'),
              ),
            );
          },
        ),
      ),
    );
  }
}
