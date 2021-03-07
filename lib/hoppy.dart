import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/config/config.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/screens/screens.dart';
import 'package:hoppy/store/store.dart';

class Hoppy extends StatelessWidget {
  ThemeMode _getCurrentThemeMode(bool? darkModeSelected) {
    if (darkModeSelected != null) {
      return darkModeSelected ? ThemeMode.dark : ThemeMode.light;
    }
    return ThemeMode.system;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(
          lazy: false,
          create: (_) => SettingsCubit(
            settingsRepository: getIt(),
          ),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (prev, curr) => prev.value.darkMode != curr.value.darkMode,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<FavoriteCubit>(
                lazy: false,
                create: (_) => FavoriteCubit(
                  beerRepository: getIt(),
                  settingsCubit: context.read(),
                ),
              ),
              BlocProvider(
                lazy: false,
                create: (_) => StatisticCubit(
                  beerRepository: getIt(),
                  checkInRepository: getIt(),
                ),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              debugShowMaterialGrid: false,
              title: 'Hoppy',
              theme: Themes.light,
              darkTheme: Themes.dark,
              themeMode: _getCurrentThemeMode(state.value.darkMode),
              home: SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
