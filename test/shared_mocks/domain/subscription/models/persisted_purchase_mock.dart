import 'package:cifraclub/domain/subscription/models/persisted_purchase.dart';
import 'package:faker/faker.dart';

PersistedPurchase getFakePersistedPurchase() {
  return PersistedPurchase(
      packageName: faker.food.restaurant(),
      pendingCompletePurchase: true,
      productId: faker.address.random.toString(),
      token: faker.lorem.sentence(),
      transactionDate: faker.date.toString());
}
