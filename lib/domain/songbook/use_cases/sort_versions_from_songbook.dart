import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class SortVersionsFromSongbook {
  final SongbookRepository _songbookRepository;
  final UserVersionRepository _userVersionRepository;

  const SortVersionsFromSongbook(this._songbookRepository, this._userVersionRepository);

  Future<Result<void, RequestError>> call(int songbookId, List<Version> versions) async {
    final versionsId = versions.map((e) => e.remoteDatabaseID!).toList();

    return (await _songbookRepository.sortVersionFromSongbook(songbookId: songbookId, versionsId: versionsId))
        .onSuccess((_) async {
      final versionsIndexed =
          versions.mapIndexed((index, element) => element.copyWith(order: index)).toList(growable: false);
      await _userVersionRepository.updateVersionsToSongbook(versionsIndexed, songbookId);
    });
  }
}
