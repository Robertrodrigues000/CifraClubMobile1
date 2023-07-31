import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
import 'package:cifraclub/domain/artist/use_cases/get_alphabetical_prefixes_list.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_video_lessons.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/artist/models/artist_song_mock.dart';
import '../../../shared_mocks/domain/home/models/video_lessons_mock.dart';

class _GetArtistVideoLessons extends Mock implements GetArtistVideoLessons {}

class _GetArtistSongs extends Mock implements GetArtistSongs {}

class _GetAlphabeticalPrefixesList extends Mock implements GetAlphabeticalPrefixesList {}

void main() {
  ArtistSongsBloc getArtistSongsBloc(
          {String? artistUrl,
          Instrument? instrument,
          _GetArtistVideoLessons? getArtistVideoLessons,
          _GetArtistSongs? getArtistSongs,
          _GetAlphabeticalPrefixesList? getAlphabeticalPrefixesList}) =>
      ArtistSongsBloc(getArtistVideoLessons ?? _GetArtistVideoLessons(), getArtistSongs ?? _GetArtistSongs(),
          getAlphabeticalPrefixesList ?? _GetAlphabeticalPrefixesList(),
          artistUrl: artistUrl, instrument: instrument);

  test("when init is called should initialize use cases", () async {
    final getArtistVideoLessons = _GetArtistVideoLessons();
    final getArtistSongs = _GetArtistSongs();
    final getAlphabeticalPrefixesList = _GetAlphabeticalPrefixesList();

    final songs = [getFakeArtistSong(), getFakeArtistSong()];
    final videoLessons = [getFakeVideoLessons(), getFakeVideoLessons()];
    final prefixes = ["A", ""];

    when(() => getArtistVideoLessons.call(any())).thenAnswer((_) => Future.value(Ok(videoLessons)));
    when(() => getArtistSongs.call(artistUrl: any(named: "artistUrl"), filter: any(named: "filter")))
        .thenAnswer((_) => Future.value(Ok(songs)));
    when(() => getAlphabeticalPrefixesList.call(any())).thenReturn(prefixes);

    final bloc = getArtistSongsBloc(
        getArtistVideoLessons: getArtistVideoLessons,
        getArtistSongs: getArtistSongs,
        getAlphabeticalPrefixesList: getAlphabeticalPrefixesList);

    await bloc.init();
    verify(() => getArtistVideoLessons.call(any())).called(1);
    verify(() => getArtistSongs.call(artistUrl: any(named: "artistUrl"), filter: any(named: "filter"))).called(1);
    verify(() => getAlphabeticalPrefixesList.call(any())).called(1);
  });

  group("when getArtistSongsAndVideoLessons is called", () {
    group("and both requests are successful", () {
      final getArtistSongs = _GetArtistSongs();
      final getArtistVideoLessons = _GetArtistVideoLessons();
      final getAlphabeticalPrefixesList = _GetAlphabeticalPrefixesList();

      final bloc = getArtistSongsBloc(
          getArtistSongs: getArtistSongs,
          getArtistVideoLessons: getArtistVideoLessons,
          getAlphabeticalPrefixesList: getAlphabeticalPrefixesList);
      final artistSongs = [getFakeArtistSong(), getFakeArtistSong()];
      final videoLessons = [getFakeVideoLessons(), getFakeVideoLessons()];
      final prefixes = ["A", ""];

      when(() => getArtistSongs.call(artistUrl: any(named: "artistUrl")))
          .thenAnswer((_) => Future.value(Ok(artistSongs)));
      when(() => getArtistVideoLessons.call(any())).thenAnswer((_) => Future.value(Ok(videoLessons)));
      when(() => getAlphabeticalPrefixesList.call(any())).thenReturn(prefixes);

      blocTest("should emit state with artist songs and video lessons",
          build: () => bloc,
          act: (bloc) => bloc.getArtistSongsAndVideoLessons(),
          expect: () => [
                isA<ArtistSongsState>()
                    .having((state) => state.songs, "artist songs", artistSongs)
                    .having((state) => state.videoLessons, "artist video lessons", videoLessons)
                    .having((state) => state.prefixes, "prefixes", prefixes)
              ]);
    });

    group("and getArtistSongs fails but getVideoLessons is success", () {
      final getArtistSongs = _GetArtistSongs();
      final getArtistVideoLessons = _GetArtistVideoLessons();

      final videoLessons = [getFakeVideoLessons(), getFakeVideoLessons()];

      final bloc = getArtistSongsBloc(
        getArtistSongs: getArtistSongs,
        getArtistVideoLessons: getArtistVideoLessons,
      );
      when(() => getArtistSongs.call(artistUrl: any(named: "artistUrl")))
          .thenAnswer((_) => Future.value(Err(ServerError())));

      when(() => getArtistVideoLessons.call(any())).thenAnswer((_) => Future.value(Ok(videoLessons)));

      blocTest("should emit artistSongsError and videoLessons",
          build: () => bloc,
          act: (bloc) => bloc.getArtistSongsAndVideoLessons(),
          expect: () => [
                isA<ArtistSongsState>()
                    .having((state) => state.songsError, "artist Songs Error", isNotNull)
                    .having((state) => state.videoLessons, "videoLessons", videoLessons)
              ]);
    });

    group("and getArtistVideoLessons fails but getArtistSongs is success", () {
      final getArtistSongs = _GetArtistSongs();
      final getArtistVideoLessons = _GetArtistVideoLessons();
      final getAlphabeticalPrefixesList = _GetAlphabeticalPrefixesList();

      final artistSongs = [getFakeArtistSong(), getFakeArtistSong()];

      final bloc = getArtistSongsBloc(
          getArtistSongs: getArtistSongs,
          getArtistVideoLessons: getArtistVideoLessons,
          getAlphabeticalPrefixesList: getAlphabeticalPrefixesList);
      when(() => getArtistSongs.call(artistUrl: any(named: "artistUrl")))
          .thenAnswer((_) => Future.value(Ok(artistSongs)));
      when(() => getArtistVideoLessons.call(any())).thenAnswer((_) => Future.value(Err(ServerError())));
      when(() => getAlphabeticalPrefixesList.call(any())).thenReturn(["A", ""]);

      blocTest("should emit videoLessonsError, songs and prefixes",
          build: () => bloc,
          act: (bloc) => bloc.getArtistSongsAndVideoLessons(),
          expect: () => [
                isA<ArtistSongsState>()
                    .having((state) => state.videoLessonsError, "video lessons error", isNotNull)
                    .having((state) => state.songs, "artist songs", artistSongs)
                    .having((state) => state.prefixes, "prefixes", ["A", ""]),
              ]);
    });
  });

  group("when instrument is not null should filter songs and video lessons", () {
    final getArtistSongs = _GetArtistSongs();
    final getArtistVideoLessons = _GetArtistVideoLessons();
    final getAlphabeticalPrefixesList = _GetAlphabeticalPrefixesList();

    final bloc = getArtistSongsBloc(
        getArtistVideoLessons: getArtistVideoLessons,
        getArtistSongs: getArtistSongs,
        getAlphabeticalPrefixesList: getAlphabeticalPrefixesList,
        instrument: Instrument.drums);

    final videoLessons = [
      getFakeVideoLessons(instrument: Instrument.drums),
      getFakeVideoLessons(instrument: Instrument.guitar),
      getFakeVideoLessons(instrument: Instrument.guitar),
    ];

    final filteredVideoLessons = videoLessons.where((element) => element.instrument == Instrument.drums);

    final filteredArtistSongs = [
      getFakeArtistSong(drums: 2),
      getFakeArtistSong(drums: 1),
      getFakeArtistSong(drums: 1),
    ];

    when(() => getArtistVideoLessons.call(any())).thenAnswer((_) => Future.value(Ok(videoLessons)));
    when(() => getArtistSongs.call(artistUrl: any(named: "artistUrl"), filter: ArtistSongFilter.drums))
        .thenAnswer((_) => Future.value(Ok(filteredArtistSongs)));
    when(() => getAlphabeticalPrefixesList.call(any())).thenReturn(["A", ""]);

    blocTest("should emit state with filtered video lessons and songs",
        build: () => bloc,
        act: (bloc) => bloc.getArtistSongsAndVideoLessons(),
        expect: () => [
              isA<ArtistSongsState>()
                  .having((state) => state.videoLessons, "filtered video lessons", filteredVideoLessons)
                  .having((state) => state.songs, "filtered songs", filteredArtistSongs)
                  .having((state) => state.prefixes, "prefixes", ["A", ""])
            ]);
  });
}
