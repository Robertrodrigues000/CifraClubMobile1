// coverage:ignore-file
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class InsertUserSongbook {
  final SongbookRepository _songbookRepository;

  InsertUserSongbook(this._songbookRepository);

  Future<int> call(Songbook songbook) {
    return _songbookRepository.insertUserSongbook(songbook);
  }
}
