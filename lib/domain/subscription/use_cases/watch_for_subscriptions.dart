import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_remote_pro_status.dart';
import 'package:cifraclub/domain/subscription/use_cases/validate_persisted_purchase.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:injectable/injectable.dart';

@singleton
@injectable
class WatchForSubscriptions {
  final GetCredentialStream _getCredentialStream;
  final SubscriptionRepository _subscriptionRepository;
  final GetRemoteProStatus _getRemoteProStatus;
  final ValidatePersistedPurchase _validatePersistedPurchase;

  WatchForSubscriptions(this._getCredentialStream, this._subscriptionRepository, this._getRemoteProStatus,
      this._validatePersistedPurchase);

  Future<void> call() async {
    logger?.log(tag: runtimeType.toString(), message: "Iniciando WatchForSubscriptions");
    _getCredentialStream().listen((credential) async {
      var remoteProStatus = await _getRemoteProStatus(credential);

      _subscriptionRepository.updateProStatus(remoteProStatus: remoteProStatus);

      if (remoteProStatus == true) {
        logger?.log(tag: runtimeType.toString(), message: "Usuário é PRO pelo servidor.");
      } else {
        // coverage:ignore-start
        logger?.log(
            tag: runtimeType.toString(), message: "Usuário não é PRO pelo servidor. Procurando por compras salvas.");
        // coverage:ignore-end
        await _validatePersistedPurchase();
      }
    });
  }
}
