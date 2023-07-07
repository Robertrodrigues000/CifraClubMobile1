import 'dart:async';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/update_pro_status_with_purchase_result.dart';
import 'package:cifraclub/domain/subscription/use_cases/validate_purchases.dart';
import 'package:cifraclub/domain/subscription/use_cases/watch_for_purchases.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

class _InAppPurchaseRepositoryMock extends Mock implements InAppPurchaseRepository {}

class _ValidatePurchasesMock extends Mock implements ValidatePurchases {}

class _UpdateProStatusWithPurchaseResultMock extends Mock implements UpdateProStatusWithPurchaseResult {}

void main() {
  final inAppPurchaseRepository = _InAppPurchaseRepositoryMock();
  final validatePurchases = _ValidatePurchasesMock();
  final updateProStatusWithPurchaseResult = _UpdateProStatusWithPurchaseResultMock();
  var purchaseStream = BehaviorSubject<List<Purchase>>();

  registerFallbackValue(PurchaseResult.valid);

  setUp(() {
    clearInteractions(inAppPurchaseRepository);
    when(inAppPurchaseRepository.cleanIosTransactions).thenAnswer((_) => SynchronousFuture(null));
    when(inAppPurchaseRepository.restorePurchases).thenAnswer((_) => SynchronousFuture(null));
    when(() => inAppPurchaseRepository.ensureInitialized).thenAnswer((_) => SynchronousFuture(true));
    when(inAppPurchaseRepository.getPurchaseStream).thenAnswer((_) => purchaseStream.stream);
    when(() => updateProStatusWithPurchaseResult.call(any())).thenReturn(null);
    registerFallbackValue(PurchaseResult.valid);
  });

  test(
      "When `WatchForPurchases` is called, it should wait for the InAppPurchaseRepository to start and then subscribe to purchase stream and restore user`s purchases",
      () async {
    final watchForPurchases =
        WatchForPurchases(inAppPurchaseRepository, validatePurchases, updateProStatusWithPurchaseResult);
    await watchForPurchases();
    verify(() => inAppPurchaseRepository.ensureInitialized).called(1);
  });

  test("When a purchase is received, the SubscriptionRepository should update the pro status accordingly", () async {
    final watchForPurchases =
        WatchForPurchases(inAppPurchaseRepository, validatePurchases, updateProStatusWithPurchaseResult);
    watchForPurchases();

    when(() => validatePurchases.call(any())).thenAnswer((_) => SynchronousFuture(PurchaseResult.valid));
    await _publishPurchasesAndWait(purchaseStream, []);

    var result = verify(() => updateProStatusWithPurchaseResult.call(captureAny())).captured.first! as PurchaseResult;
    clearInteractions(updateProStatusWithPurchaseResult);
    expect(result, PurchaseResult.valid);

    when(() => validatePurchases.call(any()))
        .thenAnswer((_) => SynchronousFuture(PurchaseResult.tokenAlreadyValidated));
    await _publishPurchasesAndWait(purchaseStream, []);

    result = verify(() => updateProStatusWithPurchaseResult.call(captureAny())).captured.first! as PurchaseResult;
    clearInteractions(updateProStatusWithPurchaseResult);
    expect(result, PurchaseResult.tokenAlreadyValidated);

    when(() => validatePurchases.call(any())).thenAnswer((_) => SynchronousFuture(PurchaseResult.unknown));
    await _publishPurchasesAndWait(purchaseStream, []);

    result = verify(() => updateProStatusWithPurchaseResult.call(captureAny())).captured.first! as PurchaseResult;
    clearInteractions(updateProStatusWithPurchaseResult);
    expect(result, PurchaseResult.unknown);

    when(() => validatePurchases.call(any())).thenAnswer((_) => SynchronousFuture(PurchaseResult.invalid));
    await _publishPurchasesAndWait(purchaseStream, []);

    result = verify(() => updateProStatusWithPurchaseResult.call(captureAny())).captured.first! as PurchaseResult;
    clearInteractions(updateProStatusWithPurchaseResult);
    expect(result, PurchaseResult.invalid);
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
