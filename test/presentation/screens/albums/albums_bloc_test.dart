import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/artist/use_cases/get_albums.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/albums/albums_bloc.dart';
import 'package:cifraclub/presentation/screens/albums/albums_state.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/artist/models/album_mock.dart';

class _GetAlbumsMock extends Mock implements GetAlbums {}

void main() {
  AlbumsBloc getAlbumsBloc({
    _GetAlbumsMock? getAlbums,
    String? artistUrl,
  }) =>
      AlbumsBloc(
        artistUrl ?? "",
        getAlbums ?? _GetAlbumsMock(),
      );

  setUpAll(() {
    registerFallbackValue([getFakeAlbum()]);
  });

  group("when init is called should update state with albums", () {
    final getAlbums = _GetAlbumsMock();
    final albums = [getFakeAlbum()];
    final bloc = getAlbumsBloc(getAlbums: getAlbums);

    when(() => getAlbums.call(
          "",
        )).thenAnswer(
      (_) => SynchronousFuture(Ok(albums)),
    );

    blocTest(
      "should update the state with albums from use case",
      build: () => bloc,
      act: (bloc) => bloc.init(),
      expect: () => [
        isA<AlbumsState>().having((state) => state.isLoading, "is Loading Albums", true),
        isA<AlbumsState>().having((state) => state.albums, "albums", albums)
      ],
    );
  });

  group("When getAlbums is called", () {
    group("when request is successful", () {
      final getAlbums = _GetAlbumsMock();
      final albums = [getFakeAlbum(), getFakeAlbum()];
      final bloc = getAlbumsBloc(getAlbums: getAlbums);

      when(() => getAlbums.call(
            "",
          )).thenAnswer(
        (_) => SynchronousFuture(Ok(albums)),
      );

      blocTest(
        "should update the state with albums from use case",
        build: () => bloc,
        act: (bloc) => bloc.getAlbums(),
        expect: () => [
          isA<AlbumsState>().having((state) => state.isLoading, "is Loading Albums", true),
          isA<AlbumsState>().having((state) => state.albums, "albums", albums)
        ],
      );
    });

    group("When request returns error", () {
      final getAlbums = _GetAlbumsMock();
      when(() => getAlbums.call(
            "",
          )).thenAnswer(
        (_) => SynchronousFuture(Err(ServerError())),
      );

      blocTest(
        "should emit an error state",
        build: () => getAlbumsBloc(getAlbums: getAlbums),
        act: (bloc) => bloc.getAlbums(),
        expect: () => [
          isA<AlbumsState>().having((state) => state.isLoading, "isLoading", isTrue),
          isA<AlbumsState>().having((state) => state.error, "error", isNotNull),
        ],
      );
    });
  });
}
