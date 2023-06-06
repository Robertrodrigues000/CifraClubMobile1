import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_remote_pro_status.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';

class WatchForSubscriptions {
  final GetCredentialStream _getCredentialStream;
  final SubscriptionRepository _subscriptionRepository;
  final InAppPurchaseRepository _inAppPurchaseRepository;
  final GetRemoteProStatus _getRemoteProStatus;

  WatchForSubscriptions(
      this._getCredentialStream, this._subscriptionRepository, this._inAppPurchaseRepository, this._getRemoteProStatus);

  Future<void> call() async {
    logger?.log(tag: runtimeType.toString(), message: "Iniciando WatchForSubscriptions");
    await _inAppPurchaseRepository.ensureInitialized;
    _getCredentialStream().listen((credential) async {
      var remoteProStatus = await _getRemoteProStatus(credential);

      _subscriptionRepository.updateProStatus(remoteProStatus: remoteProStatus);

      if (remoteProStatus == true) {
        logger?.log(tag: runtimeType.toString(), message: "Usuário é PRO pelo servidor.");
      } else {
        logger?.log(
            tag: runtimeType.toString(), message: "Usuário não é PRO pelo servidor. Procurando por compras na loja.");
        _inAppPurchaseRepository.restorePurchases();
      }
    });
  }
}
