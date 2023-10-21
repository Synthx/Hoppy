import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hoppy/app.dart';
import 'package:hoppy/core/core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupFirebase();
  setupInjector();
  runApp(const Hoppy());
}
