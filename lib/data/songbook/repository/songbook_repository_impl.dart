import 'package:cifraclub/data/songbook/data_source/songbook_data_source.dart';
import 'package:cifraclub/data/songbook/models/delete_versions_input_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_input_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_songs_input_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/version/models/version.dart';
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
  Future<Result<List<({Songbook songbook, List<Version> versions})>, RequestError>> getAllSongbooks() async {
    return (await _songbookDataSource.getAll()).map(
      (songbookList) => songbookList.map((songbook) => songbook.toDomain()).toList(),
    );
  }

  @override
  Future<Result<void, RequestError>> deleteSongbook(int songbookId) {
    return _songbookDataSource.deleteSongbook(songbookId);
  }

  @override
  Future<Result<void, RequestError>> updateSongbookData({
    required songbookId,
    String? name,
    required bool isPublic,
    required DateTime lastUpdated,
  }) {
    final input = SongbookInputDto(
      name: name,
      isPublic: isPublic,
      timestamp: lastUpdated.format(apiDateTimeFormat),
    );
    return _songbookDataSource.updateSongbookData(songbookId, input);
  }

  @override
  Future<Result<void, RequestError>> deleteVersions({required int songbookId, required List<int> versionsId}) {
    final input = DeleteVersionsInputDto(versionsId);

    return _songbookDataSource.deleteVersions(songbookId, input);
  }

  @override
  Future<Result<List<Version>, RequestError>> addSongsToSongbook({
    required int songbookId,
    required List<Version> songs,
  }) async {
    return (await _songbookDataSource.addSongsToSongbook(songbookId, SongbookSongsInputDto.fromDomain(songs)))
        .map((value) => value.map((e) => e.toDomain()).toList());
  }
}
