// coverage:ignore-file
import 'package:cifraclub/domain/subscription/models/product.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_error.dart';
import 'package:cifraclub/domain/subscription/models/purchase_state.dart';
import 'package:cifraclub/domain/subscription/models/purchase_verification.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

extension PurchaseVerificationExtension on PurchaseVerificationData {
  static PurchaseVerificationData fromDomain(PurchaseVerification purchaseVerification) => PurchaseVerificationData(
        localVerificationData: purchaseVerification.localVerificationData,
        serverVerificationData: purchaseVerification.serverVerificationData,
        source: purchaseVerification.source,
      );

  PurchaseVerification toDomain() => PurchaseVerification(
        localVerificationData: localVerificationData,
        serverVerificationData: serverVerificationData,
        source: source,
      );
}

extension PurchaseExtension on PurchaseDetails {
  static PurchaseDetails fromDomain(Purchase purchase) => PurchaseDetails(
        purchaseID: purchase.purchaseId,
        productID: purchase.productId,
        verificationData: PurchaseVerificationExtension.fromDomain(purchase.verificationData),
        transactionDate: purchase.transactionDate,
        status: PurchaseStateExtension.fromDomain(purchase.status),
      );

  Purchase toDomain() => Purchase(
      purchaseId: purchaseID,
      productId: productID,
      verificationData: verificationData.toDomain(),
      transactionDate: transactionDate,
      status: status.toDomain(),
      error: error?.toDomain(),
      pendingCompletePurchase: pendingCompletePurchase);
}

extension PurchaseStateExtension on PurchaseStatus {
  static PurchaseStatus fromDomain(PurchaseState state) {
    switch (state) {
      case PurchaseState.canceled:
        return PurchaseStatus.canceled;
      case PurchaseState.error:
        return PurchaseStatus.error;
      case PurchaseState.pending:
        return PurchaseStatus.pending;
      case PurchaseState.purchased:
        return PurchaseStatus.purchased;
      case PurchaseState.restored:
        return PurchaseStatus.restored;
    }
  }

  PurchaseState toDomain() {
    switch (this) {
      case PurchaseStatus.canceled:
        return PurchaseState.canceled;
      case PurchaseStatus.error:
        return PurchaseState.error;
      case PurchaseStatus.pending:
        return PurchaseState.pending;
      case PurchaseStatus.purchased:
        return PurchaseState.purchased;
      case PurchaseStatus.restored:
        return PurchaseState.restored;
    }
  }
}

extension ProductExtension on ProductDetails {
  static ProductDetails fromDomain(Product product) => ProductDetails(
        id: product.id,
        title: product.title,
        description: product.description,
        price: product.price,
        rawPrice: product.rawPrice,
        currencyCode: product.currencyCode,
        currencySymbol: product.currencySymbol,
      );

  Product toDomain() => Product(
        id: id,
        title: title,
        price: price,
        rawPrice: rawPrice,
        description: description,
        currencyCode: currencyCode,
        currencySymbol: currencySymbol,
      );
}

extension IAPErrorExtension on IAPError {
  PurchaseError toDomain() => PurchaseError(
        source: source,
        code: code,
        message: message,
      );
}
