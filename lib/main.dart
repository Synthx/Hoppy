import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/hoppy.dart';
import 'package:hoppy/store/store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  setupInjector();
  setupAdapter();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = StoreObserver();
  runApp(Hoppy());
}
