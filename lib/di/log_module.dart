// coverage:ignore-file
import 'package:cifraclub/data/log/log_repository_impl.dart';
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@module
abstract class LogModule {
  @singleton
  LogRepository getLogRepository(FirebaseCrashlytics crashlytics) {
    return LogRepositoryImpl(
        crashlytics: crashlytics,
        shouldLogOnConsole: (String tag, Level level) => kDebugMode,
        shouldLogOnCrashlytics: (String tag, Level level) => !kDebugMode && (level.value >= Level.INFO.value));
  }
}
