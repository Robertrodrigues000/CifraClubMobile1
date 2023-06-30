import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class AddSongsToSongbook {
  final SongbookRepository _songbookRepository;
  final UserVersionRepository _userCifraRepository;

  AddSongsToSongbook(this._songbookRepository, this._userCifraRepository);

  Future<Result<List<Version>, RequestError>> call({required int songbookId, required List<Version> songs}) async {
    return (await _songbookRepository.addSongsToSongbook(songbookId: songbookId, songs: songs))
        .onSuccess((value) async {
      await _userCifraRepository.deleteVersionsBySongbookId(songbookId);
      await _userCifraRepository.addVersionToSongbook(value, songbookId);
    });
  }
}
