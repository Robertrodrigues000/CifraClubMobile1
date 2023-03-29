import 'package:cifraclub/domain/subscription/models/purchase_verification.dart';
import 'package:faker/faker.dart';

PurchaseVerification getFakePurchaseVerification() {
  return PurchaseVerification(
    localVerificationData: faker.phoneNumber.toString(),
    serverVerificationData: faker.phoneNumber.toString(),
    source: faker.person.name(),
  );
}
