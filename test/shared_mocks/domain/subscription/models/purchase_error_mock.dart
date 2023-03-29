import 'package:cifraclub/domain/subscription/models/purchase_error.dart';
import 'package:faker/faker.dart';

PurchaseError getFakePurchaseError() {
  return PurchaseError(
    source: faker.address.toString(),
    code: faker.randomGenerator.toString(),
    message: faker.lorem.sentence(),
  );
}
