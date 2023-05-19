import 'package:cifraclub/domain/remote_config/use_cases/get_tabs_limit_constants.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTabsLimit {
  final GetTabsLimitConstants _getTabsLimitConstants;
  GetTabsLimit(this._getTabsLimitConstants);

  int call(bool isPro) {
    final tabsLimitConstants = _getTabsLimitConstants();
    return isPro ? tabsLimitConstants.maxTabsForPro : tabsLimitConstants.maxTabsForFree;
  }
}
