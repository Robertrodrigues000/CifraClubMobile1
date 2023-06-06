import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/validate_purchases.dart';

class WatchForPurchases {
  final InAppPurchaseRepository _inAppPurchaseRepository;
  final SubscriptionRepository _subscriptionRepository;
  final ValidatePurchases _validatePurchases;

  WatchForPurchases(this._inAppPurchaseRepository, this._subscriptionRepository, this._validatePurchases);

  Future<void> call() async {
    logger?.log(tag: runtimeType.toString(), message: "Iniciando WatchForPurchases");
    await _inAppPurchaseRepository.ensureInitialized;
    _inAppPurchaseRepository.getPurchaseStream().listen(_onInAppPurchaseEvent);
  }

  void _onInAppPurchaseEvent(List<Purchase> purchases) async {
    logger?.log(tag: runtimeType.toString(), message: "Validando ${purchases.length} compras.");
    var validationResult = await _validatePurchases(purchases);

    switch (validationResult) {
      case PurchaseResult.valid:
        logger?.log(tag: runtimeType.toString(), message: "Usuário possui compra na loja.");
        _subscriptionRepository.updateProStatus(storeProStatus: true);
        break;
      case PurchaseResult.invalid:
        logger?.log(tag: runtimeType.toString(), message: "Usuário não possui compra na loja.");
        _subscriptionRepository.updateProStatus(storeProStatus: false);
        break;
      case PurchaseResult.tokenAlreadyValidated:
        logger?.log(tag: runtimeType.toString(), message: "Compra já vinculada a outro usuário.");
        _subscriptionRepository.updateProStatus(storeProStatus: false);
        break;
      case PurchaseResult.unknown:
        logger?.log(
            tag: runtimeType.toString(), message: "Estado de compra indefinido. Mantendo estado anterior do PRO");
        _subscriptionRepository.updateProStatus(storeProStatus: null);
        break;
    }
  }
}
