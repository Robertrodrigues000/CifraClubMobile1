import 'package:cifraclub/di/di_setup.dart';
import 'package:logging/logging.dart';

LogRepository? get logger => getIt.isRegistered<LogRepository>() ? getIt() : null; // coverage:ignore-line

abstract class LogRepository {
  Future<void> log({
    required String tag,
    Level level,
    required String message,
    Object? error,
    StackTrace? stackTrace,
  });

  /// User ID a ser associado a erros fatais e não fatais.
  Future<void> setUserIdentifier(int id);

  Future<void> sendNonFatalCrash({
    required dynamic exception,
    StackTrace? stack,
    dynamic reason,
    Iterable<String> information = const [],
    bool fatal = false,
  });

  Future<void> setCustomKey({
    required String key,
    required String value,
  });
}
