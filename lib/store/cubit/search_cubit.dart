import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';

class SearchCubit extends Cubit<SearchState> {
  final BeerRepository beerRepository;

  SearchCubit({
    required this.beerRepository,
  }) : super(SearchState(
          beers: [],
          filter: BeerFilter(),
          loading: false,
          page: 0,
          size: 20,
        ));

  Future<void> search() async {
    emit(state.copyWith(
      loading: true,
      page: 0,
      beers: [],
      totalElements: null,
    ));
    try {
      final datasource = await beerRepository.search(
        filter: state.filter,
        page: state.page,
        size: state.size,
      );
      emit(state.copyWith(
        loading: false,
        beers: datasource.content,
        totalElements: datasource.totalElements,
      ));
    } catch (e, stackTrace) {
      addError(e, stackTrace);
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> nextPage() async {
    var currentList = state.beers;
    emit(state.copyWith(loading: true, page: state.page + 1));
    final datasource = await beerRepository.search(
      filter: state.filter,
      page: state.page,
      size: state.size,
    );
    currentList.addAll(datasource.content);
    emit(state.copyWith(
      loading: false,
      beers: currentList,
    ));
  }

  void addBeer(Beer beer) {
    var currentList = state.beers.toList();
    currentList.add(beer);
    emit(state.copyWith(
      beers: currentList,
      totalElements: (state.totalElements ?? 0) + 1,
    ));
  }

  void editBeer(Beer beer) {
    var currentList = state.beers.toList();
    var index = currentList.indexWhere((e) => e.id == beer.id);
    if (index != -1) {
      currentList[index] = beer;
      emit(state.copyWith(
        beers: currentList,
      ));
    }
  }

  void deleteBeer(Beer beer) {
    emit(state.copyWith(
      beers: state.beers.where((e) => e.id != beer.id).toList(),
      totalElements: state.totalElements! - 1,
    ));
  }

  void resetFilter() {
    emit(state.copyWith.filter(
      keyword: null,
      colors: [],
      styles: [],
      countries: [],
      degreeRange: RangeValues(0, 100),
      havePicture: null,
    ));
  }

  void setKeywordFilter(String? keyword) {
    emit(state.copyWith.filter(keyword: keyword));
  }

  void setDegreeRangeFilter(RangeValues degreeRange) {
    emit(state.copyWith.filter(degreeRange: degreeRange));
  }

  void setHavePictureFilter(bool? havePicture) {
    emit(state.copyWith.filter(havePicture: havePicture));
  }

  void addBeerStyleFilter(BeerStyle style) {
    var currentList = state.filter.styles.toList();
    currentList.add(style);
    emit(state.copyWith.filter(styles: currentList));
  }

  void removeBeerStyleFilter(BeerStyle style) {
    emit(state.copyWith.filter(
      styles: state.filter.styles.where((e) => e != style).toList(),
    ));
  }

  void addBeerColorFilter(BeerColor color) {
    var currentList = state.filter.colors.toList();
    currentList.add(color);
    emit(state.copyWith.filter(colors: currentList));
  }

  void removeBeerColorFilter(BeerColor color) {
    emit(state.copyWith.filter(
      colors: state.filter.colors.where((e) => e != color).toList(),
    ));
  }

  void addBeerCountryFilter(BeerCountry country) {
    var currentList = state.filter.countries.toList();
    currentList.add(country);
    emit(state.copyWith.filter(countries: currentList));
  }

  void removeBeerCountryFilter(BeerCountry country) {
    emit(state.copyWith.filter(
      countries: state.filter.countries.where((e) => e != country).toList(),
    ));
  }
}
