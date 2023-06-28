import 'dart:async';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/validate_purchases.dart';
import 'package:cifraclub/domain/subscription/use_cases/watch_for_purchases.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

class _SubscriptionRepositoryMock extends Mock implements SubscriptionRepository {}

class _InAppPurchaseRepositoryMock extends Mock implements InAppPurchaseRepository {}

class _ValidatePurchasesMock extends Mock implements ValidatePurchases {}

void main() {
  final inAppPurchaseRepository = _InAppPurchaseRepositoryMock();
  final subscriptionRepository = _SubscriptionRepositoryMock();
  final validatePurchases = _ValidatePurchasesMock();
  var purchaseStream = BehaviorSubject<List<Purchase>>();

  setUp(() {
    clearInteractions(inAppPurchaseRepository);
    when(inAppPurchaseRepository.cleanIosTransactions).thenAnswer((_) => SynchronousFuture(null));
    when(inAppPurchaseRepository.restorePurchases).thenAnswer((_) => SynchronousFuture(null));
    when(() => inAppPurchaseRepository.ensureInitialized).thenAnswer((_) => SynchronousFuture(true));
    when(inAppPurchaseRepository.getPurchaseStream).thenAnswer((_) => purchaseStream.stream);

    when(() => subscriptionRepository.updateProStatus(
          remoteProStatus: any(named: "remoteProStatus"),
          storeProStatus: any(named: "storeProStatus"),
        )).thenAnswer((_) {});
  });

  test(
      "When `WatchForPurchases` is called, it should wait for the InAppPurchaseRepository to start and then subscribe to purchase stream and restore user`s purchases",
      () async {
    final watchForPurchases = WatchForPurchases(inAppPurchaseRepository, subscriptionRepository, validatePurchases);
    await watchForPurchases();
    verify(() => inAppPurchaseRepository.ensureInitialized).called(1);
  });

  test("When a purchase is received, the SubscriptionRepository should update the pro status accordingly", () async {
    final watchForPurchases = WatchForPurchases(inAppPurchaseRepository, subscriptionRepository, validatePurchases);
    watchForPurchases();

    when(() => validatePurchases.call(any())).thenAnswer((_) => SynchronousFuture(PurchaseResult.valid));
    await _publishPurchasesAndWait(purchaseStream, []);

    _expectUpdateProStatus(subscriptionRepository, storeProStatus: true);

    when(() => validatePurchases.call(any()))
        .thenAnswer((_) => SynchronousFuture(PurchaseResult.tokenAlreadyValidated));
    await _publishPurchasesAndWait(purchaseStream, []);

    _expectUpdateProStatus(subscriptionRepository, storeProStatus: false);

    when(() => validatePurchases.call(any())).thenAnswer((_) => SynchronousFuture(PurchaseResult.unknown));
    await _publishPurchasesAndWait(purchaseStream, []);

    _expectUpdateProStatus(subscriptionRepository, storeProStatus: null);

    when(() => validatePurchases.call(any())).thenAnswer((_) => SynchronousFuture(PurchaseResult.invalid));
    await _publishPurchasesAndWait(purchaseStream, []);

    _expectUpdateProStatus(subscriptionRepository, storeProStatus: false);
  });
}

Future<void> _publishPurchasesAndWait(BehaviorSubject<List<Purchase>> purchaseStream, List<Purchase> purchases) async {
  var completer = Completer();
  var subscription = purchaseStream.listen(null);
  subscription.onData((_) {
    subscription.cancel();
    completer.complete();
  });
  purchaseStream.add(purchases);
  await completer.future;
}

void _expectUpdateProStatus(_SubscriptionRepositoryMock subscriptionRepository, {bool? storeProStatus}) async {
  final captured = verify(
    () => subscriptionRepository.updateProStatus(
      remoteProStatus: captureAny(named: "remoteProStatus"),
      storeProStatus: captureAny(named: "storeProStatus"),
    ),
  ).captured;

  final capturedRemoteProStatus = captured[0];
  final capturedStoreProStatus = captured[1];

  expect(capturedRemoteProStatus, null);
  expect(capturedStoreProStatus, storeProStatus);
  clearInteractions(subscriptionRepository);
}
