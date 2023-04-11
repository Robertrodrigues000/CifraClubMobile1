import 'package:cifraclub/data/subscription/models/post_order.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

void main() {
  test('When is GooglePlayPurchaseDetails should convert to android post order', () async {
    final orderDto = GooglePlayPurchaseDetails(
      productID: "e5r-532-15we",
      verificationData: PurchaseVerificationData(localVerificationData: "1", serverVerificationData: "2", source: "3"),
      transactionDate: "",
      billingClientPurchase: const PurchaseWrapper(
        orderId: "",
        packageName: "cifra_club",
        purchaseTime: 12,
        purchaseToken: "a8w74-dew2q-fdsf2",
        signature: "",
        skus: [],
        isAutoRenewing: true,
        originalJson: "",
        isAcknowledged: true,
        purchaseState: PurchaseStateWrapper.purchased,
      ),
      status: PurchaseStatus.purchased,
    );

    final androidPostOrder = PostOrder.fromPurchase(orderDto, replaceCcidAccount: true);

    expect(androidPostOrder?.app, orderDto.billingClientPurchase.packageName);
    expect(androidPostOrder?.productId, orderDto.productID);
    expect(androidPostOrder?.token, orderDto.billingClientPurchase.purchaseToken);
    expect(androidPostOrder?.confirmed, isTrue);
    expect(androidPostOrder?.subType, "subs");
    expect(androidPostOrder?.type, "google_play");
    expect(androidPostOrder?.sandbox, isNull);
    expect(androidPostOrder?.expirationDate, isNull);
  });

  test('When is AppStorePurchaseDetails should convert to ios post order', () async {
    final orderDto = AppStorePurchaseDetails(
      productID: "",
      verificationData: PurchaseVerificationData(localVerificationData: "", serverVerificationData: "", source: ""),
      transactionDate: "",
      status: PurchaseStatus.purchased,
      skPaymentTransaction: SKPaymentTransactionWrapper(
        payment: const SKPaymentWrapper(productIdentifier: ""),
        transactionState: SKPaymentTransactionStateWrapper.purchased,
      ),
    );

    final iosPostOrder = PostOrder.fromPurchase(orderDto, replaceCcidAccount: true);

    expect(iosPostOrder?.productId, orderDto.productID);
    expect(iosPostOrder?.token, orderDto.verificationData.localVerificationData);
    expect(iosPostOrder?.sandbox, isFalse);
    expect(iosPostOrder?.confirmed, isTrue);
    expect(iosPostOrder?.type, "apple");
    expect(iosPostOrder?.expirationDate, isNull);
    expect(iosPostOrder?.subType, isNull);
    expect(iosPostOrder?.app, isNull);
  });
}
