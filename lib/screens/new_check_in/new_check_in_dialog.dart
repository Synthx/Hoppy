import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/screens/new_check_in/new_check_in_state.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'new_check_in_cubit.dart';
import 'new_check_in_dialog_footer.dart';
import 'widget/beer_preview.dart';
import 'widget/check_in_date_selector.dart';
import 'widget/check_in_description_input.dart';
import 'widget/check_in_location_selector.dart';
import 'widget/check_in_serving_style_selector.dart';

class NewCheckInDialog extends StatefulWidget {
  static route(Beer beer) => MaterialPageRoute<CheckIn?>(
        builder: (_) => NewCheckInDialog(
          beer: beer,
        ),
      );

  final Beer beer;

  const NewCheckInDialog({
    required this.beer,
  });

  @override
  State createState() => _NewCheckInDialogState();
}

class _NewCheckInDialogState extends State<NewCheckInDialog> {
  final _checkInForm = FormGroup({
    'rating': FormControl<double>(
      value: 5.0,
      validators: [Validators.required],
    ),
    'servingStyle': FormControl<ServingStyle>(
      validators: [Validators.required],
    ),
    'date': FormControl<DateTime>(
      value: DateTime.now(),
      validators: [Validators.required],
    ),
    'location': FormControl<CheckInLocation>(),
    'description': FormControl(),
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

  Future<void> _onCheckInCreated(CheckIn checkIn) async {
    await context.showSuccessDialog(
      title: 'Check-in enregistré avec succès',
      content: 'Alors, elle était bonne ?',
      icon: Text('🍻', style: TextStyle(fontSize: 50)),
    );
    context.pop(checkIn);
  }

  @override
  void dispose() {
    _checkInForm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewCheckInCubit>(
      create: (_) => NewCheckInCubit(
        checkInRepository: getIt(),
        statisticCubit: context.read(),
      ),
      child: MultiBlocListener(
        listeners: [
          BlocListener<NewCheckInCubit, NewCheckInState>(
            listenWhen: (prev, curr) => prev.loading != curr.loading,
            listener: (_, state) => _onLoadingChanged(state.loading),
          ),
          BlocListener<NewCheckInCubit, NewCheckInState>(
            listenWhen: (prev, curr) =>
                prev.checkIn != curr.checkIn && curr.checkIn != null,
            listener: (_, state) => _onCheckInCreated(state.checkIn!),
          ),
        ],
        child: ReactiveForm(
          formGroup: _checkInForm,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Check-in'),
              leading: IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () => _closeDialog(),
              ),
            ),
            bottomNavigationBar: NewCheckInDialogFooter(
              form: _checkInForm,
              beer: widget.beer,
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                BeerPreview(
                  beer: widget.beer,
                ),
                CheckInServingStyleSelector(
                  form: _checkInForm,
                ),
                const Divider(height: 0),
                CheckInDateSelector(
                  form: _checkInForm,
                ),
                const Divider(height: 0),
                CheckInDescriptionInput(),
                const Divider(height: 0),
                CheckInLocationSelector(
                  form: _checkInForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
