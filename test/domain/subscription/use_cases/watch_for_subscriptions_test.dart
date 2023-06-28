import 'dart:async';

import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_remote_pro_status.dart';
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

class _Notifier extends ValueNotifier {
  _Notifier() : super(null);
}

class _InAppPurchaseRepositoryMock extends Mock implements InAppPurchaseRepository {
  final internalNotifier = _Notifier();
}

void main() {
  // ignore: close_sinks
  var credentialStream = BehaviorSubject<UserCredential>();
  var getCredentialStream = _GetCredentialStreamMock();
  var subscriptionRepository = _SubscriptionRepositoryMock();
  var inAppPurchaseRepository = _InAppPurchaseRepositoryMock();
  var getRemoteProStatus = _GetRemoteProStatusMock();
  WatchForSubscriptions? watchForSubscriptions;

  setUpAll(() async {
    registerFallbackValue(const UserCredential(isUserLoggedIn: false));
  });

  setUp(() {
    clearInteractions(inAppPurchaseRepository);
    when(inAppPurchaseRepository.cleanIosTransactions).thenAnswer((_) => SynchronousFuture(null));
    when(inAppPurchaseRepository.restorePurchases).thenAnswer((_) {
      return SynchronousFuture(null);
    });
    when(() => inAppPurchaseRepository.ensureInitialized).thenAnswer((_) => SynchronousFuture(true));
    when(inAppPurchaseRepository.getPurchaseStream).thenAnswer((_) => const Stream.empty());

    when(() => subscriptionRepository.updateProStatus(
          remoteProStatus: any(named: "remoteProStatus"),
          storeProStatus: any(named: "storeProStatus"),
        )).thenAnswer((_) {});

    when(getCredentialStream.call).thenAnswer((_) => credentialStream);

    if (watchForSubscriptions == null) {
      watchForSubscriptions = WatchForSubscriptions(
          getCredentialStream, subscriptionRepository, inAppPurchaseRepository, getRemoteProStatus);
      watchForSubscriptions!();
    }
  });

  test("When `WatchForSubscriptions` is called, it should wait for the InAppPurchaseRepository to start", () async {
    verify(() => inAppPurchaseRepository.ensureInitialized).called(1);
  });

  group("When user login/logout", () {
    test("and have purchases on remote, should become PRO", () async {
      when(() => getRemoteProStatus(any())).thenAnswer((_) => SynchronousFuture(true));

      await _addToCredentialStream(credentialStream);

      verifyNever(inAppPurchaseRepository.restorePurchases);
      _expectUpdateProStatus(subscriptionRepository, remoteProStatus: true);
    });

    test("and have no purchases on remote, should not become PRO and should look for purchases on store", () async {
      when(() => getRemoteProStatus(any())).thenAnswer((_) => SynchronousFuture(false));

      await _addToCredentialStream(credentialStream);

      verify(inAppPurchaseRepository.restorePurchases).called(1);
      _expectUpdateProStatus(subscriptionRepository, remoteProStatus: false);
    });

    test("and get orders fails, should not change PRO status and should look for purchases on store", () async {
      when(() => getRemoteProStatus(any())).thenAnswer((_) => SynchronousFuture(null));

      await _addToCredentialStream(credentialStream);

      verify(inAppPurchaseRepository.restorePurchases).called(1);
      _expectUpdateProStatus(subscriptionRepository, remoteProStatus: null);
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
