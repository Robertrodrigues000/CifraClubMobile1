// coverage:ignore-file
import 'package:cifraclub/domain/subscription/models/product.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_error.dart';
import 'package:cifraclub/domain/subscription/models/purchase_state.dart';
import 'package:cifraclub/domain/subscription/models/purchase_verification.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';

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
  static PurchaseDetails fromDomain(Purchase purchase) => purchase.purchaseDto;

  Purchase toDomain() {
    Vendor? vendor;
    String? token;
    final PurchaseState purchaseState;
    String? packageName;

    if (this is GooglePlayPurchaseDetails) {
      vendor = Vendor.playStore;
      token = (this as GooglePlayPurchaseDetails).billingClientPurchase.purchaseToken;
      packageName = (this as GooglePlayPurchaseDetails).billingClientPurchase.packageName;
    } else if (this is AppStorePurchaseDetails) {
      vendor = Vendor.appStore;
      token = verificationData.localVerificationData;
    }

    switch (status) {
      case PurchaseStatus.pending:
        purchaseState = PurchaseState.waitingStoreResponse;
        break;
      case PurchaseStatus.error:
      case PurchaseStatus.canceled:
        purchaseState = PurchaseState.error;
        break;
      case PurchaseStatus.purchased:
      case PurchaseStatus.restored: // Emitted when a not confirmed purchased is restored on app starting
        if (pendingCompletePurchase) {
          purchaseState = PurchaseState.waitingBackendValidation;
        } else {
          purchaseState = PurchaseState.idle;
        }
        break;
    }

    return Purchase(
      purchaseId: purchaseID,
      productId: productID,
      verificationData: verificationData.toDomain(),
      transactionDate: transactionDate,
      status: purchaseState,
      error: error?.toDomain(),
      pendingCompletePurchase: pendingCompletePurchase,
      token: token,
      vendor: vendor,
      packageName: packageName,
      purchaseDto: this,
    );
  }
}

extension ProductExtension on ProductDetails {
  static ProductDetails fromDomain(Product product) => product.productDto;

  Product toDomain() {
    String? introductoryPrice;
    double? rawIntroductoryPrice;

    if (this is AppStoreProductDetails) {
      introductoryPrice = (this as AppStoreProductDetails).skProduct.introductoryPrice?.price;
      if (introductoryPrice != null && introductoryPrice.isNotEmpty) {
        rawIntroductoryPrice = double.parse(introductoryPrice);
      }
    } else if (this is GooglePlayProductDetails) {
      introductoryPrice = (this as GooglePlayProductDetails).skuDetails.introductoryPrice;
      if (introductoryPrice.isNotEmpty) {
        rawIntroductoryPrice = double.parse(introductoryPrice);
      }
    }

    return Product(
      id: id,
      title: title,
      price: price,
      rawPrice: rawPrice,
      description: description,
      currencyCode: currencyCode,
      currencySymbol: currencySymbol,
      introductoryPrice: introductoryPrice,
      rawIntroductoryPrice: rawIntroductoryPrice,
      productDto: this,
    );
  }
}

extension IAPErrorExtension on IAPError {
  PurchaseError toDomain() => PurchaseError(
        source: source,
        code: code,
        message: message,
      );
}
