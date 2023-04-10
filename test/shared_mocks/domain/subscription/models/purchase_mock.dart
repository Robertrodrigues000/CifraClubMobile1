import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_state.dart';
import 'package:faker/faker.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'purchase_error_mock.dart';
import 'purchase_verification_mock.dart';

Purchase getFakePurchase() {
  final productID = faker.food.dish();
  final purchaseId = faker.food.dish();
  final verificationData = getFakePurchaseVerification();
  final verificationDataDTO = PurchaseVerificationData(
      localVerificationData: verificationData.localVerificationData,
      serverVerificationData: verificationData.serverVerificationData,
      source: verificationData.source);
  final transactionDate = faker.date.toString();

  return Purchase(
    purchaseId: purchaseId,
    productId: productID,
    verificationData: verificationData,
    transactionDate: faker.date.toString(),
    status: PurchaseState.idle,
    error: getFakePurchaseError(),
    pendingCompletePurchase: false,
    purchaseDto: PurchaseDetails(
        productID: productID,
        verificationData: verificationDataDTO,
        transactionDate: transactionDate,
        status: PurchaseStatus.pending,
        purchaseID: purchaseId),
    token: faker.lorem.sentence(),
    vendor: Vendor.playStore,
  );
}
