// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProStatusWithPurchaseResult {
  final SubscriptionRepository _subscriptionRepository;

  UpdateProStatusWithPurchaseResult(
    this._subscriptionRepository,
  );

  void call(PurchaseResult purchaseResult) {
    switch (purchaseResult) {
      case PurchaseResult.valid:
      case PurchaseResult.tokenAlreadyValidated:
        logger?.log(tag: runtimeType.toString(), message: "Usuário possui compra na loja.");
        _subscriptionRepository.updateProStatus(storeProStatus: true);
        break;
      case PurchaseResult.invalid:
        logger?.log(tag: runtimeType.toString(), message: "Usuário não possui compra na loja.");
        _subscriptionRepository.updateProStatus(storeProStatus: false);
        break;
      case PurchaseResult.unknown:
        // coverage:ignore-start
        logger?.log(
            tag: runtimeType.toString(), message: "Estado de compra indefinido. Mantendo estado anterior do PRO");
        // coverage:ignore-end
        _subscriptionRepository.updateProStatus(storeProStatus: null);
        break;
    }
  }
}
