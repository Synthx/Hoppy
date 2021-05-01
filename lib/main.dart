import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/hoppy.dart';
import 'package:hoppy/isar.g.dart';
import 'package:hoppy/store/store.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final isar = await openIsar();
  setupInjector(isar);
  setupAdapter();
  EquatableConfig.stringify = kDebugMode;
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
        '[${record.level.name}] ${record.loggerName} - ${record.time} : ${record.message}');
  });
  Bloc.observer = StoreObserver();

  if (kDebugMode) {
    runApp(Hoppy());
  } else {
    ErrorHandler(
      runAppFunction: () => runApp(Hoppy()),
    );
  }
}
