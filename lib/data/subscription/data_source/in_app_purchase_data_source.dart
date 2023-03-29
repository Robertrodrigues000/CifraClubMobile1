import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:typed_result/typed_result.dart';

import 'package:cifraclub/domain/log/repository/log_repository.dart';

class InAppPurchaseDataSource {
  final InAppPurchase inAppPurchase;

  InAppPurchaseDataSource({required this.inAppPurchase});

  Future<Result<List<ProductDetails>, IAPError>> getProducts(Set<String> ids) async {
    final ProductDetailsResponse productDetailsResponse = await inAppPurchase.queryProductDetails(ids);
    //coverage:ignore-start
    if (productDetailsResponse.notFoundIDs.isNotEmpty) {
      logger?.sendNonFatalCrash(
        exception: Exception("products ids not found: ${productDetailsResponse.notFoundIDs}"),
      );
    }
    //coverage:ignore-end
    if (productDetailsResponse.error != null) {
      return Err(productDetailsResponse.error!);
    }
    return Ok(productDetailsResponse.productDetails);
  }

  Future<bool> purchaseProduct(ProductDetails productDetails) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    return inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Stream<List<PurchaseDetails>> getPurchaseStream() {
    return inAppPurchase.purchaseStream;
  }

  Future<void> completePurchase(PurchaseDetails purchaseDetails) {
    return inAppPurchase.completePurchase(purchaseDetails);
  }

  // coverage:ignore-start
  Future<void> cleanIosTransactions() async {
    if (Platform.isIOS) {
      var skPaymentQueueWrapper = SKPaymentQueueWrapper();
      var transactions = await skPaymentQueueWrapper.transactions();

      for (var skPaymentTransactionWrapper in transactions) {
        await skPaymentQueueWrapper.finishTransaction(skPaymentTransactionWrapper);
      }
    }
  }
  // coverage:ignore-end
}
