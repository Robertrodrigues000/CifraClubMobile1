import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/artist/use_cases/get_album_detail.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/album/album_bloc.dart';
import 'package:cifraclub/presentation/screens/album/album_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/artist/models/album_detail_mock.dart';

class _GetAlbumDetailMock extends Mock implements GetAlbumDetail {}

void main() {
  AlbumBloc getAlbumBloc({
    _GetAlbumDetailMock? getAlbumDetail,
  }) =>
      AlbumBloc(
        "",
        "",
        getAlbumDetail ?? _GetAlbumDetailMock(),
      );

  setUpAll(() {
    registerFallbackValue(getFakeAlbumDetail());
  });

  group("when init is called should update state with album details", () {
    final getAlbumDetail = _GetAlbumDetailMock();
    final album = getFakeAlbumDetail();
    final bloc = getAlbumBloc(getAlbumDetail: getAlbumDetail);

    when(() => getAlbumDetail.call(albumUrl: any(named: "albumUrl"), artistUrl: any(named: "artistUrl"))).thenAnswer(
      (_) => Future.value(Ok(album)),
    );

    blocTest("should update state with album details from use case",
        build: () => bloc,
        act: (bloc) => bloc.init(),
        expect: () => [
              isA<AlbumState>().having((state) => state.isLoading, "isLoading", isTrue),
              isA<AlbumState>()
                  .having((state) => state.album, "album detail", album)
                  .having((state) => state.discs, "album discs", album.discs)
            ]);
  });

  group("When getAlbumDetail is called", () {
    group("when request is successful", () {
      final getAlbumDetail = _GetAlbumDetailMock();
      final album = getFakeAlbumDetail();
      final bloc = getAlbumBloc(getAlbumDetail: getAlbumDetail);

      when(() => getAlbumDetail.call(albumUrl: any(named: "albumUrl"), artistUrl: any(named: "artistUrl"))).thenAnswer(
        (_) => Future.value(Ok(album)),
      );

      blocTest(
        "should update the state with albums from use case",
        build: () => bloc,
        act: (bloc) => bloc.getAlbumDetail(),
        expect: () => [
          isA<AlbumState>().having((state) => state.isLoading, "isLoading", isTrue),
          isA<AlbumState>()
              .having((state) => state.album, "album detail", album)
              .having((state) => state.discs, "album discs", album.discs)
        ],
      );
    });

    group("When request returns error", () {
      final getAlbumDetail = _GetAlbumDetailMock();
      when(() => getAlbumDetail.call(artistUrl: "", albumUrl: "")).thenAnswer(
        (_) => SynchronousFuture(Err(ServerError())),
      );

      blocTest(
        "should emit an error state",
        build: () => getAlbumBloc(getAlbumDetail: getAlbumDetail),
        act: (bloc) => bloc.getAlbumDetail(),
        expect: () => [
          isA<AlbumState>().having((state) => state.isLoading, "isLoading", isTrue),
          isA<AlbumState>().having((state) => state.error, "error", isNotNull),
        ],
      );
    });
  });
}
