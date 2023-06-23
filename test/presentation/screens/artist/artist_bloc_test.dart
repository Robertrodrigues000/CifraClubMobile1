import 'package:async/async.dart' hide Result;
import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/artist/use_cases/get_albums.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_info.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart';
import 'package:cifraclub/presentation/screens/artist/artist_bloc.dart';
import 'package:cifraclub/presentation/screens/artist/artist_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/artist/models/album_mock.dart';
import '../../../shared_mocks/domain/artist/models/artist_info_mock.dart';
import '../../../shared_mocks/domain/artist/models/artist_song_mock.dart';

class _GetArtistSongsMock extends Mock implements GetArtistSongs {}

class _GetArtistInfoMock extends Mock implements GetArtistInfo {}

class _GetAlbumsMock extends Mock implements GetAlbums {}

void main() {
  ArtistBloc getArtistBloc({
    String? artistUrl,
    _GetArtistInfoMock? getArtistInfo,
    _GetArtistSongsMock? getArtistSongs,
    _GetAlbumsMock? getAlbums,
  }) =>
      ArtistBloc(
        artistUrl ?? "",
        getArtistSongs ?? _GetArtistSongsMock(),
        getArtistInfo ?? _GetArtistInfoMock(),
        getAlbums ?? _GetAlbumsMock(),
      );
  group("When getArtistSongs is called", () {
    group("when request is successful", () {
      final getArtistSongs = _GetArtistSongsMock();
      final artistSongs = [
        getFakeArtistSong(),
        getFakeArtistSong(),
      ];

      when(() => getArtistSongs.call(
          limit: any(named: "limit"), artistUrl: any(named: "artistUrl"), filter: any(named: "filter"))).thenAnswer(
        (_) => CancelableOperation.fromFuture(
          SynchronousFuture(
            Ok(artistSongs),
          ),
        ),
      );

      blocTest(
        "should emit state with artist songs from use case",
        build: () => getArtistBloc(getArtistSongs: getArtistSongs),
        act: (bloc) => bloc.getArtistSongs(),
        expect: () => [
          isA<ArtistState>().having((state) => state.songs, "songs", artistSongs),
        ],
      );
    });
  });

  group("When getArtistInfo is called", () {
    group("when request is successful", () {
      final getArtistInfo = _GetArtistInfoMock();
      final artistInfo = getFakeArtistInfo();

      when(() => getArtistInfo.call(any())).thenAnswer(
        (_) => SynchronousFuture(
          Ok(artistInfo),
        ),
      );

      blocTest(
        "should emit state with artist info from use case",
        build: () => getArtistBloc(getArtistInfo: getArtistInfo),
        act: (bloc) => bloc.getArtistInfo(),
        expect: () => [
          isA<ArtistState>().having((state) => state.isLoading, "isLoading", true),
          isA<ArtistState>().having((state) => state.artistInfo, "artist info", artistInfo),
        ],
      );
    });
  });

  group("When getArtistAlbums is called", () {
    group("when request is successful", () {
      final getArtistAlbums = _GetAlbumsMock();
      final albums = [getFakeAlbum(), getFakeAlbum()];

      when(() => getArtistAlbums.call(any())).thenAnswer(
        (_) => SynchronousFuture(
          Ok(albums),
        ),
      );

      blocTest(
        "should emit state with albums from use case",
        build: () => getArtistBloc(getAlbums: getArtistAlbums),
        act: (bloc) => bloc.getAlbums(),
        expect: () => [
          isA<ArtistState>().having((state) => state.albums, "albums", albums),
        ],
      );
    });
  });
}
