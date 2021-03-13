import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/screens/screens.dart';
import 'package:hoppy/store/store.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _settingCompleter = Completer<bool>();
  final _favoriteCompleter = Completer<bool>();
  final _statisticCompleter = Completer<bool>();

  void _completeSetting() {
    _settingCompleter.complete(true);
  }

  void _completeFavorite() {
    _favoriteCompleter.complete(true);
  }

  void _completeStatistic() {
    _statisticCompleter.complete(true);
  }

  @override
  void initState() {
    super.initState();
    // launch loading
    context.read<SettingsCubit>().load();
    context.read<FavoriteCubit>().load();
    context.read<StatisticCubit>().load();
    // wait for initialization before redirecting
    Future.wait([
      _settingCompleter.future,
      _favoriteCompleter.future,
      _statisticCompleter.future,
    ]).then((_) {
      Navigator.pushAndRemoveUntil(
        context,
        MainScreen.route(),
        (_) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (prev, curr) => prev.loading != curr.loading,
          listener: (context, _) => _completeSetting(),
        ),
        BlocListener<FavoriteCubit, FavoriteState>(
          listenWhen: (prev, curr) => prev.loading != curr.loading,
          listener: (context, _) => _completeFavorite(),
        ),
        BlocListener<StatisticCubit, StatisticState>(
          listenWhen: (prev, curr) => prev.loading != curr.loading,
          listener: (context, _) => _completeStatistic(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                const Text(
                  'Splash',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
