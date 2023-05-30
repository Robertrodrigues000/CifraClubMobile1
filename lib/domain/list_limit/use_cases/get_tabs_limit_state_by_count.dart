import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_tabs_limit.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_tabs_limit_constants.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTabLimitStateByCount {
  final GetTabsLimit _getTabsLimit;
  final GetTabsLimitConstants _getTabsLimitConstants;

  GetTabLimitStateByCount(
    this._getTabsLimit,
    this._getTabsLimitConstants,
  );

  ListLimitState call(bool isPro, int currentTabsCount) {
    final tabsLimit = _getTabsLimit(isPro);
    final tabsLimitConstants = _getTabsLimitConstants();

    return _getLimitState(
      currentCount: currentTabsCount,
      limit: tabsLimit,
      warningCountThreshold: tabsLimitConstants.tabsWarningCountThreshold,
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
