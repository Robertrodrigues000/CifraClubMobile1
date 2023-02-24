import 'package:cifraclub/data/log/log_repository_impl.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';

class _FirebaseCrashlyticsMock extends Mock implements FirebaseCrashlytics {}

void main() {
  group("when loggerRepository is created,", () {
    final crashlytics = _FirebaseCrashlyticsMock();
    when(() => crashlytics.log(any())).thenAnswer((invocation) => Future.value(null));

    test('and call setUserIdentifier, check if method setUserIdentifier of crashlytics is called', () async {
      final repository = LogRepositoryImpl(
        crashlytics: crashlytics,
        shouldLogOnConsole: (String tag, Level level) => true,
        shouldLogOnCrashlytics: (String tag, Level level) => true,
      );
      const expected = 42;
      when(() => crashlytics.setUserIdentifier(expected.toString())).thenAnswer((_) => Future.value(null));
      repository.setUserIdentifier(expected);
      verify(() => crashlytics.setUserIdentifier(expected.toString())).called(1);
    });

    test('and call setCustomKey , check if method setCustomKey of crashlytics is called', () async {
      final repository = LogRepositoryImpl(
        crashlytics: crashlytics,
        shouldLogOnConsole: (String tag, Level level) => true,
        shouldLogOnCrashlytics: (String tag, Level level) => true,
      );
      const expectedKey = "Answer";
      const expectedValue = "42";
      when(() => crashlytics.setCustomKey(expectedKey, expectedValue)).thenAnswer((_) => Future.value(null));
      repository.setCustomKey(key: expectedKey, value: expectedValue);
      verify(() => crashlytics.setCustomKey(expectedKey, expectedValue)).called(1);
    });

    test('and call sendNonFatalCrash , check if recordError report of crashlytics is called', () async {
      final repository = LogRepositoryImpl(
        crashlytics: crashlytics,
        shouldLogOnConsole: (String tag, Level level) => true,
        shouldLogOnCrashlytics: (String tag, Level level) => true,
      );
      const exception = "nonFatalError";
      final stack = StackTrace.current;
      when(() => crashlytics.recordError(any(), any(),
          information: any(named: "information"),
          fatal: any(named: "fatal"),
          reason: any(named: "reason"))).thenAnswer((_) => Future.value(null));
      repository.sendNonFatalCrash(exception: exception, stack: stack);
      verify(() => crashlytics.recordError(Error.safeToString(exception), stack,
          information: any(named: "information"), fatal: any(named: "fatal"), reason: any(named: "reason"))).called(1);
    });
  });
}
