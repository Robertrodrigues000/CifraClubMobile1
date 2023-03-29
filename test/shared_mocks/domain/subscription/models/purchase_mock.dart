import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_state.dart';
import 'package:faker/faker.dart';

import 'purchase_error_mock.dart';
import 'purchase_verification_mock.dart';

Purchase getFakePurchase() {
  return Purchase(
    purchaseId: faker.food.dish(),
    productId: faker.food.dish(),
    verificationData: getFakePurchaseVerification(),
    transactionDate: faker.date.toString(),
    status: PurchaseState.purchased,
    error: getFakePurchaseError(),
    pendingCompletePurchase: false,
  );
}
