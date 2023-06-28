import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_versions_limit_constants.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbook_versions.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class GetVersionsLimitState {
  final GetTotalSongbookVersions _getTotalSongbookVersions;
  final GetVersionsLimit _getVersionsLimit;
  final GetProStatusStream _getProStatusStream;
  final GetVersionsLimitConstants _getVersionsLimitConstants;
  GetVersionsLimitState(this._getTotalSongbookVersions, this._getVersionsLimit, this._getProStatusStream,
      this._getVersionsLimitConstants);

  Stream<ListLimitState> call(int songbookId) {
    return Rx.combineLatestList([_getTotalSongbookVersions(songbookId), _getProStatusStream()]).map((values) {
      final currentVersionsCount = values[0] as int;
      final isPro = values[1] as bool;

      final versionsLimit = _getVersionsLimit(isPro);

      if (versionsLimit <= 0) {
        return ListLimitState.withinLimit;
      }

      final diff = versionsLimit - currentVersionsCount;
      final versionsLimitConstants = _getVersionsLimitConstants();

      if (diff <= 0) {
        return ListLimitState.reached;
      } else if (diff >= 1 && diff <= versionsLimitConstants.versionsWarningCountThreshold) {
        return ListLimitState.atWarning;
      } else {
        return ListLimitState.withinLimit;
      }
    });
  }
}
