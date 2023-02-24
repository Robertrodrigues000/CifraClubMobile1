// coverage:ignore-file
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllUserSongbooks {
  final SongbookRepository _songbookRepository;

  GetAllUserSongbooks(this._songbookRepository);

  Stream<List<Songbook>> call() {
    return _songbookRepository.getAllUserSongbooks();
  }
}
