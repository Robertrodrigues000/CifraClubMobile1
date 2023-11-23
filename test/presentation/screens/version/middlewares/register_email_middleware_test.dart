import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/shared/use_cases/validate_email.dart';
import 'package:cifraclub/domain/song/use_cases/send_email_to_blocked_song.dart';
import 'package:cifraclub/domain/songbook/models/email_options_result.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/register_email_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

import '../../../../shared_mocks/domain/version/models/version_data_mock.dart';

class _ValidateEmailMock extends Mock implements ValidateEmail {}

class _SendEmailToBlockedSong extends Mock implements SendEmailToBlockedSong {}

void main() {
  test("When action is OnChangeEmail", () async {
    final actionStream = PublishSubject<VersionAction>();
    final validateEmail = _ValidateEmailMock();
    final middleware = RegisterEmailMiddleware(validateEmail, _SendEmailToBlockedSong());

    when(() => validateEmail(any())).thenAnswer((invocation) => true);

    expectLater(
      actionStream.stream,
      emitsInOrder([isA<OnValidateEmail>().having((action) => action.isValid, "isValid", true)]),
    );

    middleware.onAction(
      OnChangeEmail(email: "teste@gmail.com"),
      const VersionState(),
      actionStream.add,
    );

    await actionStream.close();
  });

  group("When action is OnSendEmail", () {
    final sendEmailToBlockedSong = _SendEmailToBlockedSong();
    final middleware = RegisterEmailMiddleware(_ValidateEmailMock(), sendEmailToBlockedSong);

    test("When is success should emit success result", () async {
      final actionStream = PublishSubject<VersionAction>();
      when(() => sendEmailToBlockedSong(any(), any())).thenAnswer((_) => SynchronousFuture(const Ok(null)));

      expectLater(
        actionStream.stream,
        emitsInOrder([isA<OnEmailValidate>().having((action) => action.result, "result", isA<SendEmailSuccess>())]),
      );

      middleware.onAction(
        OnSendEmail(email: "teste@gmail.com"),
        VersionState(version: getFakeVersionData()),
        actionStream.add,
      );

      await actionStream.close();
    });

    test("When fails and is connection error should emit SendEmailNetworkError", () async {
      final actionStream = PublishSubject<VersionAction>();
      when(() => sendEmailToBlockedSong(any(), any())).thenAnswer((_) => SynchronousFuture(Err(ConnectionError())));

      expectLater(
        actionStream.stream,
        emitsInOrder(
            [isA<OnEmailValidate>().having((action) => action.result, "result", isA<SendEmailNetworkError>())]),
      );

      middleware.onAction(
        OnSendEmail(email: "teste@gmail.com"),
        VersionState(version: getFakeVersionData()),
        actionStream.add,
      );

      await actionStream.close();
    });

    test("When fails and is server error and status code is 409 should emit SendEmailConflictError", () async {
      final actionStream = PublishSubject<VersionAction>();
      when(() => sendEmailToBlockedSong(any(), any()))
          .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 409))));

      expectLater(
        actionStream.stream,
        emitsInOrder(
            [isA<OnEmailValidate>().having((action) => action.result, "result", isA<SendEmailConflictError>())]),
      );

      middleware.onAction(
        OnSendEmail(email: "teste@gmail.com"),
        VersionState(version: getFakeVersionData()),
        actionStream.add,
      );

      await actionStream.close();
    });

    test("When fails and is server error and status code != 409 should emit SendEmailConflictError", () async {
      final actionStream = PublishSubject<VersionAction>();
      when(() => sendEmailToBlockedSong(any(), any()))
          .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 400))));

      expectLater(
        actionStream.stream,
        emitsInOrder([isA<OnEmailValidate>().having((action) => action.result, "result", isA<SendEmailError>())]),
      );

      middleware.onAction(
        OnSendEmail(email: "teste@gmail.com"),
        VersionState(version: getFakeVersionData()),
        actionStream.add,
      );

      await actionStream.close();
    });
  });
}
