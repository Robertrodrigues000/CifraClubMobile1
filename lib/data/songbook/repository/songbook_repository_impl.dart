import 'package:cifraclub/data/songbook/data_source/user_songbook_data_source.dart';
import 'package:cifraclub/data/songbook/models/user_songbook_dto.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';

class SongbookRepositoryImpl extends SongbookRepository {
  final UserSongbookDataSource _userSongbookDataSource;
  SongbookRepositoryImpl(this._userSongbookDataSource);

  @override
  Stream<List<Songbook>> getAllUserSongbooks() {
    return _userSongbookDataSource
        .getAll()
        .map((songbookList) => songbookList.map((songbook) => songbook.toDomain()).toList());
  }

  @override
  Future<int> insertUserSongbook(Songbook songbook) {
    return _userSongbookDataSource.insert(UserSongbookDto.fromDomain(songbook));
  }
}
