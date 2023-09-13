import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_data_to_songbook.dart';
import 'package:cifraclub/domain/version/use_cases/get_version_data.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class InsertVersionToSongbook {
  final GetVersionData _getVersionData;
  final InsertVersionDataToSongbook _insertVersionDataToSongbook;

  InsertVersionToSongbook(this._getVersionData, this._insertVersionDataToSongbook);

  Future<Result<int, RequestError>> call({
    required int songbookId,
    required String artistUrl,
    required String songUrl,
  }) async {
    if (songbookId == ListType.recents.localId) {
      throw Exception("Songbook cannot be recent songbook, songbookId: $songbookId");
    }

    final versionData = await _getVersionData(
      artistUrl: artistUrl,
      songUrl: songUrl,
    );

    if (versionData.isFailure) {
      return Err(versionData.getError()!);
    }

    return _insertVersionDataToSongbook(versionData: versionData.get()!, songbookId: songbookId);
  }
}
