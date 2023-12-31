import 'package:cifraclub/domain/subscription/models/product.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_error.dart';
import 'package:typed_result/typed_result.dart';

abstract class InAppPurchaseRepository {
  Future<bool> get ensureInitialized;
  Future<Result<List<Product>, PurchaseError>> getProducts(Set<String> ids);
  Future<bool> purchaseProduct(Product product);
  Future<void> completePurchase(Purchase purchase);
  Future<void> restorePurchases();
  Stream<List<Purchase>> getPurchaseStream();
  Future<void> cleanIosTransactions();
}
