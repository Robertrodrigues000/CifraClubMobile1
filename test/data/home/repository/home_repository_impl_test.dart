import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/home/data_souce/home_data_source.dart';
import 'package:cifraclub/data/home/models/home_dto.dart';
import 'package:cifraclub/data/home/repository/home_repository_impl.dart';
import 'package:cifraclub/domain/home/models/home_info.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/artist/models/artist_mock.dart';
import '../../../shared_mocks/domain/home/models/highlight_mock.dart';
import '../../../shared_mocks/domain/home/models/news_mock.dart';
import '../../../shared_mocks/domain/home/models/video_lessons_mock.dart';
import '../../../shared_mocks/domain/song/models/song_mock.dart';

class _HomeDataSourceMock extends Mock implements HomeDataSource {}

class _HomeDtoMock extends Mock implements HomeDto {}

void main() {
  group("When `getHomeInfos` is called", () {
    test("when request successful, should return HomeInfo", () async {
      final dataSource = _HomeDataSourceMock();
      final homeDto = _HomeDtoMock();
      final homeInfo = HomeInfo(
        highlights: [getFakeHighlight(), getFakeHighlight()],
        songs: [getFakeSong(), getFakeSong()],
        artists: [getFakeArtist(), getFakeArtist()],
        videoLessons: [getFakeVideoLessons(), getFakeVideoLessons()],
        news: [getFakeNews(), getFakeNews()],
      );

      final repository = HomeRepositoryImpl(dataSource);

      when(() => dataSource.getHomeInfos(any()))
          .thenAnswer((_) => CancelableOperation.fromFuture(SynchronousFuture(Ok(homeDto))));
      when(homeDto.toDomain).thenReturn(homeInfo);

      final result = await repository.getHomeInfos(null).value;

      verify(homeDto.toDomain).called(1);
      verify(() => dataSource.getHomeInfos(null)).called(1);

      expect(result.isSuccess, true);
      expect(result.get(), homeInfo);
    });

    test("when request failure, should return server error", () async {
      final dataSource = _HomeDataSourceMock();

      final repository = HomeRepositoryImpl(dataSource);

      when(() => dataSource.getHomeInfos(any()))
          .thenAnswer((invocation) => CancelableOperation.fromFuture(SynchronousFuture(Err(ServerError()))));

      final result = await repository.getHomeInfos(null).value;

      verify(() => dataSource.getHomeInfos(null)).called(1);

      expect(result.isSuccess, false);
      expect(result.getError(), isA<ServerError>());
      expect((result.getError() as ServerError).statusCode, null);
    });
  });
}
