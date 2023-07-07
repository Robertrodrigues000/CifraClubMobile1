import 'package:cifraclub/data/subscription/data_source/persisted_purchase_data_source.dart';
import 'package:cifraclub/data/subscription/models/persisted_purchase_dto.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import '../../../test_helpers/isar_test_module.dart';

void main() {
  late Isar isar;

  late PersistedPurchaseDataSource persistedPurchaseDataSource;

  setUpAll(() async {
    await IsarTestModule.initializeCore();
  });

  setUp(() async {
    isar = await IsarTestModule.getIsar();
    persistedPurchaseDataSource = PersistedPurchaseDataSource(isar: isar);
  });

  test("When setPersistedPurchase is called, the purchase should be persisted.", () async {
    var purchase = PersistedPurchaseDto(
        packageName: faker.company.name(),
        pendingCompletePurchase: false,
        productId: faker.company.name(),
        token: faker.company.name(),
        transactionDate: "");

    await persistedPurchaseDataSource.setPersistedPurchase(purchase);

    var persistedPurchase = await isar.persistedPurchaseDtos.get(PersistedPurchaseDto.persistedPurchaseId);

    expect(purchase, persistedPurchase);
  });

  test("When getPersistedPurchase is called should return the persisted purchase", () async {
    var persistedPurchase = await persistedPurchaseDataSource.getPersistedPurchase();

    expect(persistedPurchase, null);

    var purchase = PersistedPurchaseDto(
        packageName: faker.company.name(),
        pendingCompletePurchase: false,
        productId: faker.company.name(),
        token: faker.company.name(),
        transactionDate: "");

    await isar.writeTxn(() async {
      isar.persistedPurchaseDtos.put(purchase);
    });

    persistedPurchase = await persistedPurchaseDataSource.getPersistedPurchase();

    expect(persistedPurchase, purchase);
  });

  tearDown(() {
    isar.close(deleteFromDisk: true);
  });
}
