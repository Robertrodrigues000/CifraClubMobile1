import 'package:cifraclub/data/subscription/data_source/persisted_purchase_data_source.dart';
import 'package:cifraclub/data/subscription/models/persisted_purchase_dto.dart';
import 'package:cifraclub/data/subscription/repository/persisted_purchase_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/subscription/models/persisted_purchase_mock.dart';

class _PersistedPurchaseDataSourceMock extends Mock implements PersistedPurchaseDataSource {}

class _PersistedPurchaseDtoMock extends Mock implements PersistedPurchaseDto {}

void main() {
  setUpAll(() {
    registerFallbackValue(PersistedPurchaseDto.fromDomain(getFakePersistedPurchase()));
  });

  var persistedPurchaseDataSource = _PersistedPurchaseDataSourceMock();

  test(
      "When setPersistedPurchase is called, the purchase should be passed to setPersistedPurchase method of the datasource",
      () {
    var purchase = getFakePersistedPurchase();

    var persistedPurchaseRepositoryImpl = PersistedPurchaseRepositoryImpl(persistedPurchaseDataSource);

    when(() => persistedPurchaseDataSource.setPersistedPurchase(any())).thenAnswer((_) => SynchronousFuture(null));

    persistedPurchaseRepositoryImpl.setPersistedPurchase(purchase);

    var persistedPurchaseDto = verify(() => persistedPurchaseDataSource.setPersistedPurchase(captureAny()))
        .captured
        .first! as PersistedPurchaseDto;

    expect(purchase.packageName, persistedPurchaseDto.packageName);
    expect(purchase.pendingCompletePurchase, persistedPurchaseDto.pendingCompletePurchase);
    expect(purchase.productId, persistedPurchaseDto.productId);
    expect(purchase.token, persistedPurchaseDto.token);
    expect(purchase.transactionDate, persistedPurchaseDto.transactionDate);
  });

  test(
      "When getPersistedPurchase is called, the purchase should be retrieved from getPersistedPurchase method of the datasource",
      () async {
    var persistedPurchaseDto = _PersistedPurchaseDtoMock();
    var persistedPurchase = getFakePersistedPurchase();

    when(persistedPurchaseDto.toDomain).thenReturn(persistedPurchase);

    var persistedPurchaseRepositoryImpl = PersistedPurchaseRepositoryImpl(persistedPurchaseDataSource);

    when(() => persistedPurchaseDataSource.getPersistedPurchase())
        .thenAnswer((_) => SynchronousFuture(persistedPurchaseDto));

    var purchase = await persistedPurchaseRepositoryImpl.getPersistedPurchase();

    expect(purchase, persistedPurchase);
  });
}
