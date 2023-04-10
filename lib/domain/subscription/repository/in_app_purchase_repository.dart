import 'package:cifraclub/domain/subscription/models/product.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_error.dart';
import 'package:flutter/foundation.dart';
import 'package:typed_result/typed_result.dart';

enum InAppRepositoryStatus {
  idle,
  purchasing,
  validating,
  purchased,
  validationRequestError,
  purchaseRequestError,
  serverError,
  deniedByApi,
  tokenAlreadyValidated,
  paymentDenied,
}

abstract class InAppPurchaseRepository implements ValueNotifier {
  Future<Result<List<Product>, PurchaseError>> getProducts(Set<String> ids);
  Future<void> restorePurchases();
  Future<bool> purchaseProduct(Product product);
  Future<void> completePurchase(Purchase purchase);
  Stream<List<Purchase>> getPurchaseStream();
  Future<bool> get ensureInitialized;
  InAppRepositoryStatus get state;
  Future<void> close();
  Future<void> cleanIosTransactions();
}
