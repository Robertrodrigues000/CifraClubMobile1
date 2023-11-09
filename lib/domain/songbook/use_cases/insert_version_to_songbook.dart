import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook_error.dart';
import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart';
import 'package:cifraclub/domain/songbook/use_cases/is_version_on_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_data_to_songbook.dart';
import 'package:cifraclub/domain/version/use_cases/get_version_data.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class InsertVersionToSongbook {
  final GetVersionData _getVersionData;
  final InsertVersionDataToSongbook _insertVersionDataToSongbook;
  final IsVersionOnSongbook _isVersionOnSongbook;
  final GetVersionsLimitState _getVersionsLimitState;
  final GetVersionsLimit _getVersionsLimit;

  InsertVersionToSongbook(
    this._getVersionData,
    this._insertVersionDataToSongbook,
    this._isVersionOnSongbook,
    this._getVersionsLimitState,
    this._getVersionsLimit,
  );

  Future<Result<int, SongbookError>> call({
    required int songbookId,
    required String artistUrl,
    required String songUrl,
    bool? isPro,
  }) async {
    if (songbookId == ListType.recents.localId) {
      throw Exception("Songbook cannot be recent songbook, songbookId: $songbookId");
    }

    if (ListType.getListTypeById(songbookId) == ListType.user) {
      final versionListLimit = await _getVersionsLimitState(songbookId).first;
      if (versionListLimit == ListLimitState.reached) {
        final versionsLimit = _getVersionsLimit(isPro!);
        return Err(SongbookVersionsLimitReachedError(versionsLimit));
      }
    }

    final versionData = await _getVersionData(
      artistUrl: artistUrl,
      songUrl: songUrl,
    );

    if (versionData.isFailure) {
      return Err(SongbookRequestError(versionData.getError()!));
    }

    if (ListType.getListTypeById(songbookId) != ListType.user) {
      final isVersionOnList = await _isVersionOnSongbook(versionData.get()!.versionId, songbookId);
      if (isVersionOnList) {
        return Err(SongbookRepeatedSongError());
      }
    }

    final result = await _insertVersionDataToSongbook(versionData: versionData.get()!, songbookId: songbookId);

    if (result.isFailure) {
      return Err(SongbookRequestError(result.getError()!));
    }

    return Ok(result.get()!);
  }
}
