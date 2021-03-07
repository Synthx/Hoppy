import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;

  SettingsCubit({
    required this.settingsRepository,
  }) : super(SettingsState(
          loading: false,
          value: Settings(),
        ));

  void load() async {
    emit(state.copyWith(loading: true));
    var settings = await settingsRepository.load();
    emit(state.copyWith(loading: false, value: settings));
  }

  void darkModeChanged(bool darkMode) async {
    await settingsRepository.setDarkMode(darkMode);
    emit(state.copyWith.value(darkMode: darkMode));
  }

  void nameChanged(String name) async {
    await settingsRepository.setName(name);
    emit(state.copyWith.value(name: name));
  }

  void setKey(GlobalKey mainKey) {
    emit(state.copyWith(mainKey: mainKey));
  }
}
