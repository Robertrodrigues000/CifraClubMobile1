import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_tabs_limit.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_tabs_limit_constants.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbook_cifras.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class GetTabsLimitState {
  final GetTotalSongbookCifras _getTotalSongbookCifras;
  final GetTabsLimit _getTabsLimit;
  final GetProStatusStream _getProStatusStream;
  final GetTabsLimitConstants _getTabsLimitConstants;
  GetTabsLimitState(
      this._getTotalSongbookCifras, this._getTabsLimit, this._getProStatusStream, this._getTabsLimitConstants);

  Stream<ListLimitState> call(int songbookId) {
    return Rx.combineLatestList([_getTotalSongbookCifras(songbookId), _getProStatusStream()]).map((values) {
      final currentTabsCount = values[0] as int;
      final isPro = values[1] as bool;

      final tabsLimit = _getTabsLimit(isPro);

      if (tabsLimit <= 0) {
        return ListLimitState.withinLimit;
      }

      final diff = tabsLimit - currentTabsCount;
      final tabsLimitConstants = _getTabsLimitConstants();

      if (diff <= 0) {
        return ListLimitState.reached;
      } else if (diff >= 1 && diff <= tabsLimitConstants.tabsWarningCountThreshold) {
        return ListLimitState.atWarning;
      } else {
        return ListLimitState.withinLimit;
      }
    });
  }
}
