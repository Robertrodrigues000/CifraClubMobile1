import 'package:cifraclub/domain/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/update_pro_status_with_purchase_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _SubscriptionRepositoryMock extends Mock implements SubscriptionRepository {}

void main() {
  test(
      "When called with PurchaseResult.valid, the use case should update the subscription repository with store pro status true",
      () {
    var subscriptionRepository = _SubscriptionRepositoryMock();
    when(() => subscriptionRepository.updateProStatus(
        remoteProStatus: any(named: "remoteProStatus"), storeProStatus: any(named: "storeProStatus"))).thenReturn(null);

    var updateProStatusWithPurchaseResult = UpdateProStatusWithPurchaseResult(subscriptionRepository);

    updateProStatusWithPurchaseResult(PurchaseResult.valid);

    var status = verify(() => subscriptionRepository.updateProStatus(
          remoteProStatus: captureAny(named: "remoteProStatus"),
          storeProStatus: captureAny(named: "storeProStatus"),
        )).captured;

    expect(listEquals(status, [null, true]), isTrue);
  });

  test(
      "When called with PurchaseResult.tokenAlreadyValidated, the use case should update the subscription repository with store pro status true",
      () {
    var subscriptionRepository = _SubscriptionRepositoryMock();
    when(() => subscriptionRepository.updateProStatus(
        remoteProStatus: any(named: "remoteProStatus"), storeProStatus: any(named: "storeProStatus"))).thenReturn(null);

    var updateProStatusWithPurchaseResult = UpdateProStatusWithPurchaseResult(subscriptionRepository);

    updateProStatusWithPurchaseResult(PurchaseResult.tokenAlreadyValidated);

    var status = verify(() => subscriptionRepository.updateProStatus(
          remoteProStatus: captureAny(named: "remoteProStatus"),
          storeProStatus: captureAny(named: "storeProStatus"),
        )).captured;

    expect(listEquals(status, [null, true]), isTrue);
  });

  test(
      "When called with PurchaseResult.invalid, the use case should update the subscription repository with store pro status false",
      () {
    var subscriptionRepository = _SubscriptionRepositoryMock();
    when(() => subscriptionRepository.updateProStatus(
        remoteProStatus: any(named: "remoteProStatus"), storeProStatus: any(named: "storeProStatus"))).thenReturn(null);

    var updateProStatusWithPurchaseResult = UpdateProStatusWithPurchaseResult(subscriptionRepository);

    updateProStatusWithPurchaseResult(PurchaseResult.invalid);

    var status = verify(() => subscriptionRepository.updateProStatus(
          remoteProStatus: captureAny(named: "remoteProStatus"),
          storeProStatus: captureAny(named: "storeProStatus"),
        )).captured;

    expect(listEquals(status, [null, false]), isTrue);
  });

  test(
      "When called with PurchaseResult.unknown, the use case should update the subscription repository with store pro status null",
      () {
    var subscriptionRepository = _SubscriptionRepositoryMock();
    when(() => subscriptionRepository.updateProStatus(
        remoteProStatus: any(named: "remoteProStatus"), storeProStatus: any(named: "storeProStatus"))).thenReturn(null);

    var updateProStatusWithPurchaseResult = UpdateProStatusWithPurchaseResult(subscriptionRepository);

    updateProStatusWithPurchaseResult(PurchaseResult.unknown);

    var status = verify(() => subscriptionRepository.updateProStatus(
          remoteProStatus: captureAny(named: "remoteProStatus"),
          storeProStatus: captureAny(named: "storeProStatus"),
        )).captured;

    expect(listEquals(status, [null, null]), isTrue);
  });
}
