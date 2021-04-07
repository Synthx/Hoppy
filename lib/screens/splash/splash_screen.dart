import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/screens/screens.dart';
import 'package:hoppy/store/store.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Timer timer;
  final _settingCompleter = Completer<bool>();
  final _favoriteCompleter = Completer<bool>();
  final _statisticCompleter = Completer<bool>();
  late String key;

  void _completeSetting() {
    _settingCompleter.complete(true);
  }

  void _completeFavorite() {
    _favoriteCompleter.complete(true);
  }

  void _completeStatistic() {
    _statisticCompleter.complete(true);
  }

  void _changeText() {
    final keys = ['draft', 'liver', 'beer', 'glass', 'other'];
    setState(() {
      key = keys.random();
    });
  }

  @override
  void initState() {
    super.initState();
    // set statistic cubit
    context.read<SettingsCubit>().setStatisticCubit(context.read());
    // change text quote
    _changeText();
    timer = Timer.periodic(
      Duration(seconds: 3),
      (_) => _changeText(),
    );
    // launch loading
    context.read<SettingsCubit>().load();
    context.read<FavoriteCubit>().load();
    context.read<StatisticCubit>().load();
    // wait for initialization before redirecting
    Future.wait([
      _settingCompleter.future,
      _favoriteCompleter.future,
      _statisticCompleter.future,
      Future.delayed(Duration(seconds: 2)),
    ]).then((_) {
      var firstVisit = context.read<SettingsCubit>().state.value.firstVisit;
      Navigator.pushAndRemoveUntil(
        context,
        MainScreen.route(),
        (_) => false,
      );
      if (firstVisit == null || firstVisit == false) {
        Navigator.push(
          context,
          OnBoardScreen.route(),
        );
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
            padding: const EdgeInsets.all(kDefaultPadding * 2),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
                Text(
                  Localization.of(context).splash_texts(key),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const Spacer(flex: 1),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                const SizedBox(height: 20),
                Text(
                  Localization.of(context).legal_text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
