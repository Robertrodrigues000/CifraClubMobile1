import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_versions_limit_constants.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetVersionLimitStateByCount {
  final GetVersionsLimit _getVersionsLimit;
  final GetVersionsLimitConstants _getVersionsLimitConstants;

  GetVersionLimitStateByCount(
    this._getVersionsLimit,
    this._getVersionsLimitConstants,
  );

  ListLimitState call(bool isPro, int currentVersionsCount) {
    final versionsLimit = _getVersionsLimit(isPro);
    final versionsLimitConstants = _getVersionsLimitConstants();

    return _getLimitState(
      currentCount: currentVersionsCount,
      limit: versionsLimit,
      warningCountThreshold: versionsLimitConstants.versionsWarningCountThreshold,
    );
  }

  ListLimitState _getLimitState({
    required int currentCount,
    required int limit,
    required int warningCountThreshold,
  }) {
    if (limit <= 0) {
      return ListLimitState.withinLimit;
    }

    final diff = limit - currentCount;

    if (diff <= 0) {
      return ListLimitState.reached;
    } else if (diff >= 1 && diff <= warningCountThreshold) {
      return ListLimitState.atWarning;
    } else {
      return ListLimitState.withinLimit;
    }
  }
}
