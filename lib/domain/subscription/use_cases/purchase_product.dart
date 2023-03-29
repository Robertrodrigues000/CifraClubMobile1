// coverage:ignore-file
import 'package:cifraclub/domain/subscription/models/product.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class PurchaseProduct {
  final InAppPurchaseRepository inAppPurchaseRepository;

  PurchaseProduct(this.inAppPurchaseRepository);

  Future<bool> call(Product product) => inAppPurchaseRepository.purchaseProduct(product);
}
