// coverage:ignore-file
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';

class CompletePurchase {
  final InAppPurchaseRepository _inAppPurchaseRepository;

  CompletePurchase(this._inAppPurchaseRepository);

  Future<void> call(Purchase purchase) async {
    try {
      await _inAppPurchaseRepository.completePurchase(purchase);
    } catch (e) {
      logger?.sendNonFatalCrash(
        exception: Exception("Failed to confirm purchase with store"),
      );
    }
  }
}
