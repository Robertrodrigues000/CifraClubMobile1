import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/artist/use_cases/get_albums.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_info.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart';
import 'package:cifraclub/domain/artist/use_cases/get_default_instruments.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
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

class _GetDefaultInstrumentsMock extends Mock implements GetDefaultInstruments {}

void main() {
  ArtistBloc getArtistBloc({
    String? artistUrl,
    _GetArtistInfoMock? getArtistInfo,
    _GetArtistSongsMock? getArtistSongs,
    _GetAlbumsMock? getAlbums,
    _GetDefaultInstrumentsMock? getDefaultInstruments,
  }) =>
      ArtistBloc(
        artistUrl ?? "",
        getArtistSongs ?? _GetArtistSongsMock(),
        getArtistInfo ?? _GetArtistInfoMock(),
        getAlbums ?? _GetAlbumsMock(),
        getDefaultInstruments ?? _GetDefaultInstrumentsMock(),
      );

  group("When init is called", () {
    group("when request getArtistInfo and getArtistSongs is successful", () {
      final getArtistAlbums = _GetAlbumsMock();
      final getArtistInfo = _GetArtistInfoMock();
      final artistInfo = getFakeArtistInfo();
      final getArtistSongs = _GetArtistSongsMock();
      final artistSongs = [
        getFakeArtistSong(),
        getFakeArtistSong(),
      ];
      final getDefaultInstruments = _GetDefaultInstrumentsMock();
      final defaultInstruments = [Instrument.bass, Instrument.cavaco];

      when(() => getDefaultInstruments.call(any())).thenAnswer(
        (_) => SynchronousFuture(
          defaultInstruments,
        ),
      );

      when(() => getArtistInfo(any())).thenAnswer(
        (_) {
          return Future.value(
            Ok(artistInfo),
          );
        },
      );

      when(() => getArtistSongs(
          limit: any(named: "limit"), artistUrl: any(named: "artistUrl"), filter: any(named: "filter"))).thenAnswer(
        (_) {
          return Future.value(
            Ok(artistSongs),
          );
        },
      );

      when(() => getArtistAlbums.call(any())).thenAnswer(
        (_) => Future.value(
          Err(ServerError()),
        ),
      );

      blocTest(
        "should emit state with songs and artist info from use case",
        build: () => getArtistBloc(
            getAlbums: getArtistAlbums,
            getArtistInfo: getArtistInfo,
            getArtistSongs: getArtistSongs,
            getDefaultInstruments: getDefaultInstruments),
        act: (bloc) => bloc.init(),
        expect: () => [
          isA<ArtistState>().having((state) => state.isLoading, "isLoading", true),
          isA<ArtistState>()
              .having((state) => state.songs, "artist songs", artistSongs)
              .having((state) => state.artistInfo, "artist info", artistInfo)
              .having((state) => state.instruments, "instruments", defaultInstruments)
              .having((state) => state.isLoading, "isLoading", false)
        ],
      );
    });

    group("when request getArtistInfo  or getArtistSongs fails", () {
      final error = ServerError(statusCode: 404);

      final getArtistAlbums = _GetAlbumsMock();
      final albums = [getFakeAlbum(), getFakeAlbum()];
      final getArtistInfo = _GetArtistInfoMock();
      final getArtistSongs = _GetArtistSongsMock();
      final artistSongs = [
        getFakeArtistSong(),
        getFakeArtistSong(),
      ];
      final getDefaultInstruments = _GetDefaultInstrumentsMock();
      final defaultInstruments = [Instrument.bass, Instrument.cavaco];

      when(() => getArtistAlbums.call(any())).thenAnswer(
        (_) => Future.value(
          Ok(albums),
        ),
      );

      when(() => getArtistInfo.call(any())).thenAnswer(
        (_) => Future.value(
          Err(error),
        ),
      );

      when(() => getArtistSongs.call(
          limit: any(named: "limit"), artistUrl: any(named: "artistUrl"), filter: any(named: "filter"))).thenAnswer(
        (_) => Future.value(
          Ok(artistSongs),
        ),
      );

      when(() => getDefaultInstruments.call(any())).thenAnswer(
        (_) => Future.value(
          defaultInstruments,
        ),
      );

      blocTest(
        "should emit state with error from the use case that failed",
        build: () => getArtistBloc(
            getAlbums: getArtistAlbums,
            getArtistInfo: getArtistInfo,
            getArtistSongs: getArtistSongs,
            getDefaultInstruments: getDefaultInstruments),
        act: (bloc) => bloc.init(),
        expect: () => [
          isA<ArtistState>().having((state) => state.isLoading, "isLoading", true),
          isA<ArtistState>()
              .having((state) => state.error, "error", error)
              .having((state) => state.isLoading, "isLoading", false)
        ],
      );
    });
  });

  group("when onInstrumentSelected is called", () {
    blocTest(
      "should emit state with selected instrument",
      build: getArtistBloc,
      act: (bloc) => bloc.onInstrumentSelected(Instrument.bass),
      expect: () => [
        isA<ArtistState>().having((state) => state.selectedInstrument, "selected instrument", Instrument.bass),
      ],
    );
  });
}
