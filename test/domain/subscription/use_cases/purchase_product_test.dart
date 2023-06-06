import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/purchase_product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

import '../../../shared_mocks/domain/subscription/models/product_mock.dart';

class _InAppPurchaseRepositoryMock extends Mock implements InAppPurchaseRepository {}

class _SubscriptionRepositoryMock extends Mock implements SubscriptionRepository {}

void main() {
  var inAppPurchaseRepository = _InAppPurchaseRepositoryMock();
  var subscriptionRepository = _SubscriptionRepositoryMock();

  var purchaseProduct = PurchaseProduct(inAppPurchaseRepository, subscriptionRepository);

  registerFallbackValue(getFakeProduct());

  test(
      'When purchase product is called, it should call the method on the repository only if the user isn`t already PRO',
      () async {
    when(() => inAppPurchaseRepository.purchaseProduct(any())).thenAnswer((_) => SynchronousFuture(true));

    when(subscriptionRepository.getProStatusStream).thenAnswer((_) => BehaviorSubject.seeded(true));

    expect(await purchaseProduct(getFakeProduct()), false);
    verifyNever(() => inAppPurchaseRepository.purchaseProduct(any()));

    when(subscriptionRepository.getProStatusStream).thenAnswer((_) => BehaviorSubject.seeded(false));

    expect(await purchaseProduct(getFakeProduct()), true);
    verify(() => inAppPurchaseRepository.purchaseProduct(any())).called(1);
  });
}
