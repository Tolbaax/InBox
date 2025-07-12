import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/core/injection/injector.dart' as di;
import 'package:timeago/timeago.dart' as timeago;

import 'app.dart';
import 'core/error/crashlytics.dart';
import 'core/shared/bloc_observer.dart';
import 'core/utils/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Bloc.observer = AppBlocObserver();

  await di.init();

  setupCrashlytics();

  timeago.setLocaleMessages('en', timeago.EnShortMessages());

  runApp(const MyApp());
}
