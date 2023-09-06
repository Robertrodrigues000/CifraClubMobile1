import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_last_updated.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class SortVersionsFromSongbook {
  final SongbookRepository _songbookRepository;
  final UserVersionRepository _userVersionRepository;
  final UpdateSongbookLastUpdated _updateSongbookLastUpdated;

  const SortVersionsFromSongbook(
      this._songbookRepository, this._userVersionRepository, this._updateSongbookLastUpdated);

  Future<Result<void, RequestError>> call(int songbookId, List<Version> versions) async {
    final versionsId = versions.map((e) => e.remoteDatabaseId!).toList();

    return _songbookRepository
        .sortVersionFromSongbook(songbookId: songbookId, versionsId: versionsId)
        .then((value) async {
      if (value.isSuccess) {
        final versionsIndexed =
            versions.mapIndexed((index, element) => element.copyWith(order: index)).toList(growable: false);
        await _updateSongbookLastUpdated(songbookId);
        await _userVersionRepository.updateVersionsToSongbook(versionsIndexed, songbookId);
      }
      return value;
    });
  }
}
