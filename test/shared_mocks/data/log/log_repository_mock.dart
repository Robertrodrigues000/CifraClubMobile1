import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:logging/logging.dart';
import 'package:mocktail/mocktail.dart';

class LogRepositoryMock extends Mock implements LogRepository {
  static LogRepositoryMock getDummy() {
    registerFallbackValue(Level.FINE);
    final logRepository = LogRepositoryMock();
    when(() => logRepository.log(tag: any(named: "tag"), message: any(named: "message"), level: any(named: "level"), error: any(named: "error"), stackTrace: any(named: "stackTrace")))
        .thenAnswer((invocation) => Future.value(null));
    when(() => logRepository.sendNonFatalCrash(
        exception: any(named: "exception"),
        stack: any(named: "stack"),
        reason: any(named: "reason"),
        fatal: any(named: "fatal"),
        information: any(named: "information"))).thenAnswer((invocation) => Future.value(null));
    when(() => logRepository.setCustomKey(key: any(named: "key"), value: any(named: "value"))).thenAnswer((invocation) => Future.value(null));
    when(() => logRepository.setUserIdentifier(any())).thenAnswer((invocation) => Future.value(null));
    return logRepository;
  }
}
