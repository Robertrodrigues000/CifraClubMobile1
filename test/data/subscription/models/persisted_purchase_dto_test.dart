import 'package:cifraclub/data/subscription/models/persisted_purchase_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../shared_mocks/domain/subscription/models/persisted_purchase_mock.dart';

void main() {
  test('fromDomain should correctly convert persistedPurchase to persistedPurchaseDto', () async {
    var purchase = getFakePersistedPurchase();
    var persistedPurchaseDto = PersistedPurchaseDto.fromDomain(purchase);

    expect(persistedPurchaseDto.productId, purchase.productId);
    expect(persistedPurchaseDto.transactionDate, purchase.transactionDate);
    expect(persistedPurchaseDto.pendingCompletePurchase, purchase.pendingCompletePurchase);
    expect(persistedPurchaseDto.token, purchase.token);
    expect(persistedPurchaseDto.packageName, purchase.packageName);
  });

  test('toDomain should correctly convert persistedPurchaseDto to persistedPurchase', () async {
    var persistedPurchaseDto = PersistedPurchaseDto.fromDomain(getFakePersistedPurchase());

    var persistedPurchase = persistedPurchaseDto.toDomain();

    expect(persistedPurchase.productId, persistedPurchaseDto.productId);
    expect(persistedPurchase.transactionDate, persistedPurchaseDto.transactionDate);
    expect(persistedPurchase.pendingCompletePurchase, persistedPurchaseDto.pendingCompletePurchase);
    expect(persistedPurchase.token, persistedPurchaseDto.token);
    expect(persistedPurchase.packageName, persistedPurchaseDto.packageName);
  });
}
