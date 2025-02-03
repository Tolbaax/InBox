import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

// Set up Crashlytics to handle errors
void setupCrashlytics() {
  // Handle uncaught "fatal" errors from the framework
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Handle uncaught asynchronous errors
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}
