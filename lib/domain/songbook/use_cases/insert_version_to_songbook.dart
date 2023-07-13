import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/models/songbook_version_input.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class InsertVersionToSongbook {
  final SongbookRepository _songbookRepository;
  final UserVersionRepository _userVersionRepository;

  InsertVersionToSongbook(this._songbookRepository, this._userVersionRepository);

  Future<Result<Version, RequestError>> call(
      {required int songbookId, required SongbookVersionInput versionInput}) async {
    return (await _songbookRepository.addVersionToSongbook(songbookId: songbookId, versionInput: versionInput))
        .onSuccess((value) async {
      await _userVersionRepository.addVersionToSongbook([value], songbookId);
    });
  }
}
