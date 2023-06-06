import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'dart:developer' as developer;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

typedef LogCondition = bool Function(String tag, Level level);

class LogRepositoryImpl extends LogRepository {
  final LogCondition shouldLogOnConsole;
  final LogCondition shouldLogOnCrashlytics;
  final FirebaseCrashlytics crashlytics;

  LogRepositoryImpl(
      {required this.crashlytics, required this.shouldLogOnConsole, required this.shouldLogOnCrashlytics});

  // coverage:ignore-start
  @override
  Future<void> log(
      {required String tag, Level level = Level.FINE, required String message, Object? error, StackTrace? stackTrace}) {
    if (shouldLogOnConsole(tag, level)) {
      developer.log(
        "${_logLevelToEmoji(level)} $message",
        time: DateTime.now(),
        level: level.value,
        name: tag,
        error: error,
        stackTrace: stackTrace,
      );
    }

    if (shouldLogOnCrashlytics(tag, level)) {
      return crashlytics.log("$tag: $message");
    }
    return Future.value();
  }
  // coverage:ignore-end

  @override
  Future<void> sendNonFatalCrash(
      {required exception, StackTrace? stack, reason, Iterable<String> information = const [], bool fatal = false}) {
    if (kDebugMode) {
      log(tag: runtimeType.toString(), message: exception.toString(), level: Level.WARNING);
    }
    return crashlytics.recordError(
      Error.safeToString(exception),
      stack ?? StackTrace.current,
      fatal: fatal,
      reason: reason,
      information: information,
    );
  }

  @override
  Future<void> setUserIdentifier(int id) {
    return crashlytics.setUserIdentifier("$id");
  }

  @override
  Future<void> setCustomKey({required String key, required String value}) {
    return crashlytics.setCustomKey(key, value);
  }

  // coverage:ignore-start
  String _logLevelToEmoji(Level level) {
    if (level == Level.FINEST) {
      return "🔍";
    }
    if (level == Level.FINER) {
      return "🕵️‍️";
    }
    if (level == Level.FINE) {
      return "📃️";
    }
    if (level == Level.CONFIG) {
      return "⚙️";
    }
    if (level == Level.INFO) {
      return "ℹ️";
    }
    if (level == Level.WARNING) {
      return "⚠️";
    }
    if (level == Level.SEVERE) {
      return "🚨";
    }
    if (level == Level.SHOUT) {
      return "📢";
    }
    return "👋";
  }
  // coverage:ignore-end
}
