import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

import 'beer_detail_state.dart';

class BeerDetailCubit extends Cubit<BeerDetailState> {
  final BeerRepository beerRepository;
  final SettingsCubit settingsCubit;

  BeerDetailCubit({
    required this.beerRepository,
    required this.settingsCubit,
  }) : super(BeerDetailState(
          loading: false,
        ));

  Future<void> delete(Beer beer) async {
    final context = settingsCubit.state.mainKey!.currentContext!;
    final result = await showCupertinoDialog<bool>(
      context: context,
      builder: (_) => ConfirmActionDialog(
        content:
            'Cette action est irréversible, êtes-vous sur de vouloir faire cela ?',
      ),
    );

    if (result == null) return;

    emit(state.copyWith(loading: true));
    await beerRepository.delete(beer);
    emit(state.copyWith(loading: false));

    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (context, _, __) => SuccessNotificationDialog(
        content: 'Bière supprimée avec succès',
      ),
    );
    Navigator.pop(context, true);
  }

  Future<void> edit(Beer beer) async {}
}
