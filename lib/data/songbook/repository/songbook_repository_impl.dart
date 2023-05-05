import 'package:cifraclub/data/songbook/data_source/songbook_data_source.dart';
import 'package:cifraclub/data/songbook/models/songbook_input_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/extensions/date_time_extension.dart';
import 'package:typed_result/typed_result.dart';

class SongbookRepositoryImpl extends SongbookRepository {
  final SongbookDataSource _songbookDataSource;

  SongbookRepositoryImpl(this._songbookDataSource);

  @override
  Future<Result<Songbook, RequestError>> insertSongbook({
    required String name,
    required bool isPublic,
    required DateTime createdAt,
  }) async {
    final input = SongbookInputDto(
      name: name,
      isPublic: isPublic,
      timestamp: createdAt.format(apiDateTimeFormat),
    );
    return (await _songbookDataSource.insertSongbook(input)).map((e) => e.toDomain().copyWith(createdAt: createdAt));
  }

  @override
  Future<Result<List<Songbook>, RequestError>> getAllSongbooks() async {
    return (await _songbookDataSource.getAll()).map(
      (songbookList) => songbookList.map((songbook) => songbook.toDomain()).toList(),
    );
  }

  @override
  Future<Result<void, RequestError>> deleteSongbook(int songbookId) {
    return _songbookDataSource.deleteSongbook(songbookId);
  }
}
