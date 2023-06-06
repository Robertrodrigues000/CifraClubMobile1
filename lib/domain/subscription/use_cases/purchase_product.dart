import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/subscription/models/product.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class PurchaseProduct {
  final InAppPurchaseRepository inAppPurchaseRepository;
  final SubscriptionRepository subscriptionRepository;

  PurchaseProduct(this.inAppPurchaseRepository, this.subscriptionRepository);

  Future<bool> call(Product product) async {
    if (subscriptionRepository.getProStatusStream().valueOrNull ?? true) {
      logger?.sendNonFatalCrash(exception: Exception("ProUserTryingToPurchaseAgain"));
      return Future.value(false);
    }
    return inAppPurchaseRepository.purchaseProduct(product);
  }
}
