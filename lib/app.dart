import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hoppy/screen/screen.dart';
import 'package:hoppy/store/store.dart';
import 'package:hoppy/theme/theme.dart';

class Hoppy extends StatelessWidget {
  const Hoppy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthStore(),
      child: MaterialApp.router(
        title: 'Hoppy',
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: themeData,
        themeMode: ThemeMode.light,
        routerConfig: router,
      ),
    );
  }
}
