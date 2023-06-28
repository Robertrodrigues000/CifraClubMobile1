// ignore_for_file: unused_import

import 'dart:async';

import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:cifraclub/domain/preferences/use_cases/get_is_pro_preference.dart';
import 'package:cifraclub/domain/preferences/use_cases/set_is_pro_preference.dart';
import 'package:cifraclub/domain/subscription/repository/subscription_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/verify_pro_status.dart';
import 'package:rxdart/rxdart.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final VerifyProStatus _verifyProStatus;
  bool? _storeProStatus;
  bool? _remoteProStatus;
  final SetIsProPreference _setIsProPreference;
  final GetIsProPreference _getIsProPreference;
  // ignore_for_file: close_sinks
  // ignoring rule because SubscriptionRepositoryImpl is a singleton
  late BehaviorSubject<bool> _proStatusStream;

  SubscriptionRepositoryImpl(
    this._verifyProStatus,
    this._getIsProPreference,
    this._setIsProPreference,
  ) {
    _proStatusStream = BehaviorSubject<bool>.seeded(_getIsProPreference());
    logger?.log(tag: runtimeType.toString(), message: "ProStatusInicial: ${_getIsProPreference()}");
  }

  @override
  BehaviorSubject<bool> getProStatusStream() {
    return _proStatusStream;
  }

  @override
  void updateProStatus({bool? remoteProStatus, bool? storeProStatus}) async {
    _remoteProStatus = remoteProStatus ?? _remoteProStatus;
    _storeProStatus = storeProStatus ?? _storeProStatus;

    var proStatus = _verifyProStatus(
      remoteProStatus: _remoteProStatus,
      storeProStatus: _storeProStatus,
      currentProStatus: _getIsProPreference(),
    );
    if (proStatus != _proStatusStream.valueOrNull) {
      logger?.log(tag: runtimeType.toString(), message: "Publicando proStatus: $proStatus");
      await _setIsProPreference(proStatus);
      _proStatusStream.add(proStatus);
    }
  }
}
