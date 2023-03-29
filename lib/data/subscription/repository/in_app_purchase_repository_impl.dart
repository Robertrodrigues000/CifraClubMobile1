import 'package:cifraclub/data/subscription/data_source/in_app_purchase_data_source.dart';
import 'package:cifraclub/data/subscription/extension/subscription_domain_extension.dart';
import 'package:cifraclub/domain/subscription/models/product.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_error.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:typed_result/typed_result.dart';

class InAppPurchaseRepositoryImpl extends InAppPurchaseRepository {
  final InAppPurchaseDataSource _inAppPurchaseDataSource;

  InAppPurchaseRepositoryImpl(this._inAppPurchaseDataSource);

  @override
  Future<Result<List<Product>, PurchaseError>> getProducts(Set<String> ids) async {
    final result = await _inAppPurchaseDataSource.getProducts(ids);

    return result.map((value) => value.map((e) => e.toDomain()).toList()).mapError((error) => error.toDomain());
  }

  @override
  Future<bool> purchaseProduct(Product product) {
    return _inAppPurchaseDataSource.purchaseProduct(ProductExtension.fromDomain(product));
  }

  @override
  Stream<List<Purchase>> getPurchaseStream() {
    return _inAppPurchaseDataSource.getPurchaseStream().map((event) => event.map((e) => e.toDomain()).toList());
  }

  @override
  Future<void> completePurchase(Purchase purchase) =>
      _inAppPurchaseDataSource.completePurchase(PurchaseExtension.fromDomain(purchase));

  @override
  Future<void> cleanIosTransactions() => _inAppPurchaseDataSource.cleanIosTransactions();
}
