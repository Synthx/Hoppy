import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/widget/widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'add_beer_cubit.dart';
import 'add_beer_dialog_footer.dart';
import 'add_beer_state.dart';
import 'widget/beer_color_selector.dart';
import 'widget/beer_country_selector.dart';
import 'widget/beer_degree_input.dart';
import 'widget/beer_name_input.dart';
import 'widget/beer_style_selector.dart';
import 'widget/upload_beer_picture.dart';

class AddBeerDialog extends StatefulWidget {
  static route() => MaterialPageRoute<Beer?>(
        builder: (_) => AddBeerDialog(),
      );

  @override
  State createState() => _AddBeerDialogState();
}

class _AddBeerDialogState extends State<AddBeerDialog> {
  final _addBeerForm = FormGroup({
    'picturePath': FormControl(),
    'name': FormControl(
      validators: [Validators.required, Validators.maxLength(64)],
    ),
    'title': FormControl(
      validators: [Validators.maxLength(100)],
    ),
    'color': FormControl<BeerColor>(
      validators: [Validators.required],
    ),
    'style': FormControl<BeerStyle>(
      validators: [Validators.required],
    ),
    'country': FormControl<BeerCountry>(
      validators: [Validators.required],
    ),
    'degree': FormControl<double>(
      validators: [Validators.required],
    ),
  });

  Future<void> _onClose() async {
    if (_addBeerForm.dirty) {
      final result = await showCupertinoDialog<bool?>(
        context: context,
        barrierDismissible: false,
        builder: (_) => ConfirmActionDialog(
          content:
              'Il semblerait que vous ayez saisi des informations, êtes-vous sur de vouloir quitter cette page ?',
        ),
      );

      if (result != null && result) {
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
    }
  }

  void _onLoadingChanged(bool loading) {
    if (loading) {
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        pageBuilder: (context, _, __) => LoadingDialog(),
      );
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _onBeerCreated(Beer beer) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (context, _, __) => SuccessNotificationDialog(
        title: 'Bière ajoutée avec succès',
        content: 'Et une plus dans votre collection, ça commence à faire beaucoup non ?',
        icon: Text('🍺', style: TextStyle(fontSize: 50)),
      ),
    );
    Navigator.pop(context, beer);
  }

  @override
  void dispose() {
    _addBeerForm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddBeerCubit>(
      create: (_) => AddBeerCubit(
        beerRepository: getIt(),
        statisticCubit: context.read(),
      ),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AddBeerCubit, AddBeerState>(
            listenWhen: (prev, curr) => prev.loading != curr.loading,
            listener: (_, state) => _onLoadingChanged(state.loading),
          ),
          BlocListener<AddBeerCubit, AddBeerState>(
            listenWhen: (prev, curr) => prev.beer != curr.beer,
            listener: (_, state) => _onBeerCreated(state.beer!),
          ),
        ],
        child: ReactiveForm(
          formGroup: _addBeerForm,
          child: Scaffold(
            backgroundColor: Theme.of(context).cardColor,
            appBar: AppBar(
              title: const Text('Ajouter une bière'),
              leading: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => _onClose(),
              ),
            ),
            bottomNavigationBar: AddBeerDialogFooter(
              form: _addBeerForm,
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                UploadBeerPicture(
                  form: _addBeerForm,
                ),
                BeerNameInput(),
                const Divider(height: 0),
                BeerColorSelector(
                  form: _addBeerForm,
                ),
                const Divider(height: 0),
                BeerDegreeInput(),
                const Divider(height: 0),
                BeerStyleSelector(
                  form: _addBeerForm,
                ),
                const Divider(height: 0),
                BeerCountrySelector(
                  form: _addBeerForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
