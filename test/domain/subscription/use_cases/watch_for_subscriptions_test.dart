import 'dart:async';

import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_remote_pro_status.dart';
import 'package:cifraclub/domain/subscription/use_cases/validate_persisted_purchase.dart';
import 'package:cifraclub/domain/subscription/use_cases/watch_for_subscriptions.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

class _GetCredentialStreamMock extends Mock implements GetCredentialStream {}

class _SubscriptionRepositoryMock extends Mock implements SubscriptionRepository {}

class _GetRemoteProStatusMock extends Mock implements GetRemoteProStatus {}

class _ValidatePersistedPurchaseMock extends Mock implements ValidatePersistedPurchase {}

void main() {
  // ignore: close_sinks
  var credentialStream = BehaviorSubject<UserCredential>();
  var getCredentialStream = _GetCredentialStreamMock();
  var subscriptionRepository = _SubscriptionRepositoryMock();
  var getRemoteProStatus = _GetRemoteProStatusMock();
  var validatePersistedPurchase = _ValidatePersistedPurchaseMock();
  WatchForSubscriptions? watchForSubscriptions;

  setUpAll(() async {
    registerFallbackValue(const UserCredential(isUserLoggedIn: false));
  });

  setUp(() {
    when(() => subscriptionRepository.updateProStatus(
          remoteProStatus: any(named: "remoteProStatus"),
          storeProStatus: any(named: "storeProStatus"),
        )).thenAnswer((_) {});

    when(getCredentialStream.call).thenAnswer((_) => credentialStream);

    when(validatePersistedPurchase.call).thenAnswer((_) => SynchronousFuture(null));

    if (watchForSubscriptions == null) {
      watchForSubscriptions = WatchForSubscriptions(
          getCredentialStream, subscriptionRepository, getRemoteProStatus, validatePersistedPurchase);
      watchForSubscriptions!();
    }
  });

  group("When user login/logout", () {
    test("and have purchases on remote, should become PRO", () async {
      when(() => getRemoteProStatus(any())).thenAnswer((_) => SynchronousFuture(true));

      await _addToCredentialStream(credentialStream);

      _expectUpdateProStatus(subscriptionRepository, remoteProStatus: true);
    });

    test("and have no purchases on remote, should not become PRO and should look for purchases on store", () async {
      when(() => getRemoteProStatus(any())).thenAnswer((_) => SynchronousFuture(false));

      await _addToCredentialStream(credentialStream);

      _expectUpdateProStatus(subscriptionRepository, remoteProStatus: false);
    });
  });
}

Future<void> _addToCredentialStream(BehaviorSubject<UserCredential> credentialStream) async {
  var completer = Completer();
  credentialStream.listen((_) {
    if (!completer.isCompleted) {
      completer.complete();
    }
  });
  credentialStream.add(const UserCredential(isUserLoggedIn: true));
  return completer.future;
}

void _expectUpdateProStatus(_SubscriptionRepositoryMock subscriptionRepository, {bool? remoteProStatus}) async {
  final captured = verify(
    () => subscriptionRepository.updateProStatus(
      remoteProStatus: captureAny(named: "remoteProStatus"),
      storeProStatus: captureAny(named: "storeProStatus"),
    ),
  ).captured;

  final capturedRemoteProStatus = captured[0];
  final capturedStoreProStatus = captured[1];

  expect(capturedRemoteProStatus, remoteProStatus);
  expect(capturedStoreProStatus, null);
  clearInteractions(subscriptionRepository);
}
