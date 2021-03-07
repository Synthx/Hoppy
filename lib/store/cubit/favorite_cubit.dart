import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/widget/widget.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final BeerRepository beerRepository;
  final SettingsCubit settingsCubit;

  FavoriteCubit({
    required this.beerRepository,
    required this.settingsCubit,
  }) : super(FavoriteState(
          beers: [],
          loading: false,
        ));

  Future<void> load() async {
    emit(state.copyWith(loading: true));
    final beers = await beerRepository.findAllFavorite();
    emit(state.copyWith(loading: false, beers: beers));
  }

  Future<void> addBeer(Beer beer) async {
    if (state.beers.length + 1 > Constant.maxFavorite) {
      showGeneralDialog(
        context: settingsCubit.state.mainKey!.currentContext!,
        barrierDismissible: false,
        pageBuilder: (context, _, __) => ErrorNotificationDialog(
          content: '',
        ),
      );
      return;
    }

    beer.favorite = true;
    await beerRepository.update(beer);
    emit(state.copyWith(beers: state.beers + [beer]));
  }

  Future<void> removeBeer(Beer beer) async {
    beer.favorite = false;
    await beerRepository.update(beer);
    final beers = state.beers.where((b) => b.key != beer.key).toList();
    emit(state.copyWith(beers: beers));
  }
}
