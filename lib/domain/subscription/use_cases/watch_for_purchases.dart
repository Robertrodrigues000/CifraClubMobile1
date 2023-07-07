import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/update_pro_status_with_purchase_result.dart';
import 'package:cifraclub/domain/subscription/use_cases/validate_purchases.dart';
import 'package:injectable/injectable.dart';

@singleton
@injectable
class WatchForPurchases {
  final InAppPurchaseRepository _inAppPurchaseRepository;
  final ValidatePurchases _validatePurchases;
  final UpdateProStatusWithPurchaseResult _updateProStatusWithPurchaseResult;

  WatchForPurchases(this._inAppPurchaseRepository, this._validatePurchases, this._updateProStatusWithPurchaseResult);

  Future<void> call() async {
    logger?.log(tag: runtimeType.toString(), message: "Iniciando WatchForPurchases");
    await _inAppPurchaseRepository.ensureInitialized;
    _inAppPurchaseRepository.getPurchaseStream().listen(_onInAppPurchaseEvent);
  }

  void _onInAppPurchaseEvent(List<Purchase> purchases) async {
    logger?.log(tag: runtimeType.toString(), message: "Validando ${purchases.length} compras.");
    var validationResult = await _validatePurchases(purchases);

    _updateProStatusWithPurchaseResult(validationResult);
  }
}
