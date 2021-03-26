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
      id: value['id'] as String,
      name: value['name'] as String,
      degree: value['degree'] as double,
      color: value['color'] as BeerColor,
      style: value['style'] as BeerStyle,
      country: value['country'] as BeerCountry,
      picturePath: value['picturePath'] as String?,
      title: value['title'] as String?,
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
