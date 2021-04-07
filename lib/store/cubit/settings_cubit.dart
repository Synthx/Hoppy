import 'package:bloc/bloc.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/store/store.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;
  final BeerService beerService;
  final CheckInRepository checkInRepository;
  late final StatisticCubit statisticCubit;

  SettingsCubit({
    required this.settingsRepository,
    required this.beerService,
    required this.checkInRepository,
  }) : super(SettingsState(
          loading: false,
          value: Settings(),
        ));

  void load() async {
    emit(state.copyWith(loading: true));
    var settings = await settingsRepository.load();
    emit(state.copyWith(loading: false, value: settings));
  }

  void setStatisticCubit(StatisticCubit statisticCubit) {
    this.statisticCubit = statisticCubit;
  }

  void darkModeChanged(bool darkMode) async {
    await settingsRepository.setDarkMode(darkMode);
    emit(state.copyWith.value(darkMode: darkMode));
  }

  void nameChanged(String name) async {
    await settingsRepository.setName(name);
    emit(state.copyWith.value(name: name));
  }

  void firstVisitChanged(bool firstVisit) async {
    await settingsRepository.setFirstVisit(firstVisit);
    emit(state.copyWith.value(firstVisit: firstVisit));
  }

  void deleteData() async {
    var newState = state.copyWith(loading: true);
    newState = newState.copyWith.value(
      name: '',
      darkMode: null,
    );
    emit(newState);
    try {
      await settingsRepository.reset();
      await beerService.deleteAll();
      await checkInRepository.deleteAll();
      await statisticCubit.load();
      emit(state.copyWith(loading: false));
    } catch (e, stacktrace) {
      addError(e, stacktrace);
      emit(state.copyWith(loading: false));
    }
  }
}
