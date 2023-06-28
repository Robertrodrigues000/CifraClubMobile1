import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/song/data_source/song_data_source.dart';
import 'package:cifraclub/data/song/models/top_songs_dto.dart';
import 'package:cifraclub/data/song/repository/song_repository_impl.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/song/models/song.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/song/models/song_mock.dart';

class _SongDataSourceMock extends Mock implements SongDataSource {}

class _TopSongsDtoMock extends Mock implements TopSongsDto {}

void main() {
  group("When getTopSongs() is called", () {
    test("Request successful", () async {
      final songDataSource = _SongDataSourceMock();
      final paginatedList = PaginatedList<Song>(items: [getFakeSong()], hasMoreResults: true);
      final topSongsDto = _TopSongsDtoMock();

      when(topSongsDto.toDomain).thenReturn(paginatedList);

      when(() => songDataSource.getTopSongs(limit: any(named: "limit"), offset: any(named: "offset"))).thenAnswer(
        (_) => CancelableOperation.fromFuture(
          SynchronousFuture(
            Ok(topSongsDto),
          ),
        ),
      );

      final repository = SongRepositoryImpl(songDataSource: songDataSource);
      final result = await repository.getTopSongs(limit: 2, offset: 0).value;

      verify(topSongsDto.toDomain).called(1);

      expect(result.isSuccess, true);
      expect(result.get()!.items.length, paginatedList.items.length);
      expect(result.get()!.hasMoreResults, paginatedList.hasMoreResults);
      expect(result.get()!.items.first, paginatedList.items.first);
    });

    test("Request failed", () async {
      final songDataSource = _SongDataSourceMock();

      when(() => songDataSource.getTopSongs(limit: 2, offset: 0)).thenAnswer(
        (_) => CancelableOperation.fromFuture(
          SynchronousFuture(
            Err(ServerError()),
          ),
        ),
      );

      final repository = SongRepositoryImpl(songDataSource: songDataSource);
      final result = await repository.getTopSongs(limit: 2, offset: 0).value;

      expect(result.isFailure, true);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, null);
    });
  });
}
