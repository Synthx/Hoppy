import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/edit_beer/edit_beer.dart';
import 'package:hoppy/widget/widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditBeerDialog extends StatefulWidget {
  static route(Beer beer) => MaterialPageRoute<Beer?>(
        builder: (_) => EditBeerDialog(
          beer: beer,
        ),
      );

  final Beer beer;

  const EditBeerDialog({
    required this.beer,
  });

  @override
  State createState() => _EditBeerDialogState();
}

class _EditBeerDialogState extends State<EditBeerDialog> {
  final _editBeerForm = FormGroup({
    'id': FormControl(),
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

  void _closeDialog() {
    context.pop();
  }

  void _onLoadingChanged(bool loading) {
    if (loading) {
      context.showLoadingDialog();
    } else {
      context.pop();
    }
  }

  Future<void> _onBeerEdited(Beer beer) async {
    await context.showSuccessDialog(
      title: 'Bière modifié avec succès',
      content:
          'Et une plus dans votre collection, ça commence à faire beaucoup non ?',
      icon: Text('🍺', style: TextStyle(fontSize: 50)),
    );
    context.pop(beer);
  }

  @override
  void dispose() {
    _editBeerForm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditBeerCubit>(
      create: (_) => EditBeerCubit(
        beerRepository: getIt(),
        statisticCubit: context.read(),
      ),
      child: MultiBlocListener(
        listeners: [
          BlocListener<EditBeerCubit, EditBeerState>(
            listenWhen: (prev, curr) => prev.loading != curr.loading,
            listener: (_, state) => _onLoadingChanged(state.loading),
          ),
          BlocListener<EditBeerCubit, EditBeerState>(
            listenWhen: (prev, curr) =>
                prev.beer != curr.beer && curr.beer != null,
            listener: (_, state) => _onBeerEdited(state.beer!),
          ),
        ],
        child: ReactiveForm(
          formGroup: _editBeerForm,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Modifier une bière'),
              leading: IconButton(
                onPressed: () => _closeDialog(),
                icon: Icon(Icons.chevron_left),
              ),
            ),
            bottomNavigationBar: EditBeerDialogFooter(
              form: _editBeerForm,
            ),
            body: FutureBuilder<Beer?>(
              future: getIt<BeerRepository>().find(widget.beer.key),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                }

                final beer = snapshot.data;
                if (beer == null) {
                  context.pop();
                  return Container();
                }

                _editBeerForm.patchValue({
                  'id': beer.id,
                  'name': beer.name,
                  'color': beer.color,
                  'degree': beer.degree,
                  'style': beer.style,
                  'country': beer.country,
                });
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      UploadBeerPicture(
                        form: _editBeerForm,
                      ),
                      BeerNameInput(),
                      const Divider(height: 0),
                      BeerColorSelector(
                        form: _editBeerForm,
                      ),
                      const Divider(height: 0),
                      BeerDegreeInput(),
                      const Divider(height: 0),
                      BeerStyleSelector(
                        form: _editBeerForm,
                      ),
                      const Divider(height: 0),
                      BeerCountrySelector(
                        form: _editBeerForm,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
