import 'dart:async';

import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/preferences/use_case/get_is_pro_preference.dart';
import 'package:cifraclub/domain/preferences/use_case/set_is_pro_preference.dart';
import 'package:cifraclub/domain/subscription/repository/in_app_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart';
import 'package:rxdart/rxdart.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final InAppPurchaseRepository inAppPurchaseRepository;
  final _initialized = Completer<bool>();
  final SetIsProPreference _setIsProPreference;
  final GetIsProPreference _getIsProPreference;

  @override
  Future<bool> get ensureInitialized => _initialized.future;

  // ignore_for_file: close_sinks
  // ignoring rule because SubscriptionRepositoryImpl is a singleton
  final BehaviorSubject<bool> _proStatusStream = BehaviorSubject<bool>.seeded(false);

  SubscriptionRepositoryImpl(
    this.inAppPurchaseRepository,
    this._getIsProPreference,
    this._setIsProPreference,
  ) : super() {
    _proStatusStream.add(_getIsProPreference() ?? false);
    inAppPurchaseRepository.ensureInitialized.then((value) {
      inAppPurchaseRepository.addListener(_onInAppPurchaseEvent);
      logger?.log(tag: runtimeType.toString(), message: "Creating subscription repository impl");
      inAppPurchaseRepository.restorePurchases().then((_) {
        _initialized.complete(value);
      });
    });
  }

  void _onInAppPurchaseEvent() async {
    switch (inAppPurchaseRepository.state) {
      case InAppRepositoryStatus.idle:
      case InAppRepositoryStatus.validating:
      case InAppRepositoryStatus.validationRequestError:
      case InAppRepositoryStatus.serverError:
      case InAppRepositoryStatus.purchasing:
      case InAppRepositoryStatus.purchaseRequestError:
        logger?.log(tag: runtimeType.toString(), message: "Mantendo estado anterior do PRO");
        break; // Mantém o estado anterior do status de PRO

      case InAppRepositoryStatus.purchased:
        _proStatusStream.add(true);
        await _setIsProPreference(true);
        logger?.log(tag: runtimeType.toString(), message: "Setando estado PRO para TRUE");
        break;

      case InAppRepositoryStatus.deniedByApi:
      case InAppRepositoryStatus.tokenAlreadyValidated:
      case InAppRepositoryStatus.paymentDenied:
        _proStatusStream.add(false);
        await _setIsProPreference(false);
        logger?.log(tag: runtimeType.toString(), message: "Setando estado PRO para FALSE");
        break;
    }
  }

  @override
  Stream<bool> getProStatusStream() {
    return _proStatusStream;
  }
}
