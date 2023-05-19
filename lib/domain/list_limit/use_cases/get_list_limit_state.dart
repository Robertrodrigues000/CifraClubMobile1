import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbooks.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class GetListLimitState {
  final GetTotalSongbooks _getTotalSongbooks;
  final GetProStatusStream _getProStatusStream;
  final GetListLimit _getListLimit;
  final GetListLimitConstants _getListLimitConstants;

  GetListLimitState(this._getTotalSongbooks, this._getProStatusStream, this._getListLimit, this._getListLimitConstants);

  Stream<ListLimitState> call() {
    return Rx.combineLatestList([_getTotalSongbooks(), _getProStatusStream()]).map((values) {
      final currentListCount = values[0] as int;
      final isPro = values[1] as bool;

      final listLimit = _getListLimit(isPro);

      if (listLimit <= 0) {
        return ListLimitState.withinLimit;
      }

      final diff = listLimit - currentListCount;
      final listLimitConstants = _getListLimitConstants();

      if (diff <= 0) {
        return ListLimitState.reached;
      } else if (diff >= 1 && diff <= listLimitConstants.listWarningCountThreshold) {
        return ListLimitState.atWarning;
      } else {
        return ListLimitState.withinLimit;
      }
    });
  }
}
