// coverage:ignore-file
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetSongbookById {
  final SongbookRepository _songbookRepository;

  GetSongbookById(this._songbookRepository);

  Future<Result<({Songbook songbook, List<Version> versions}), RequestError>> call(int songbookId) {
    return _songbookRepository.getSongbookById(songbookId: songbookId);
  }
}
