import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs_filtered_by_search.dart';
import 'package:cifraclub/domain/artist/use_cases/get_alphabetical_prefixes_list.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_video_lessons.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_page.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/artist/models/artist_song_mock.dart';
import '../../../shared_mocks/domain/home/models/video_lessons_mock.dart';

class _GetArtistVideoLessons extends Mock implements GetArtistVideoLessons {}

class _GetArtistSongs extends Mock implements GetArtistSongs {}

class _GetArtistSongsFilteredBySearch extends Mock implements GetArtistSongsFilteredBySearch {}

class _GetAlphabeticalPrefixesList extends Mock implements GetAlphabeticalPrefixesList {}

void main() {
  ArtistSongsBloc getArtistSongsBloc({
    _GetArtistVideoLessons? getArtistVideoLessons,
    _GetArtistSongs? getArtistSongs,
    _GetArtistSongsFilteredBySearch? getArtistSongsFilteredBySearch,
    _GetAlphabeticalPrefixesList? getAlphabeticalPrefixesList,
    Instrument? instrument,
  }) =>
      ArtistSongsBloc(
        getArtistVideoLessons ?? _GetArtistVideoLessons(),
        getArtistSongs ?? _GetArtistSongs(),
        getArtistSongsFilteredBySearch ?? _GetArtistSongsFilteredBySearch(),
        getAlphabeticalPrefixesList ?? _GetAlphabeticalPrefixesList(),
        artistUrl: "",
        instrument: instrument ?? Instrument.guitar,
      );

  test("when init is called should initialize use cases", () async {
    final getArtistVideoLessons = _GetArtistVideoLessons();
    final getArtistSongs = _GetArtistSongs();
    final songs = [getFakeArtistSong(), getFakeArtistSong()];
    final videoLessons = [getFakeVideoLessons(), getFakeVideoLessons()];
    final getAlphabeticalPrefixesList = _GetAlphabeticalPrefixesList();
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

      when(() => getArtistSongs.call(artistUrl: any(named: "artistUrl"), filter: any(named: "filter")))
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
                    .having((state) => state.alphabeticalPrefixes, "prefixes", prefixes)
              ]);
    });

    group("and getArtistSongs fails but getVideoLessons is success", () {
      final getArtistSongs = _GetArtistSongs();
      final getArtistVideoLessons = _GetArtistVideoLessons();
      final getAlphabeticalPrefixesList = _GetAlphabeticalPrefixesList();

      final videoLessons = [getFakeVideoLessons(), getFakeVideoLessons()];
      final prefixes = ["A", ""];

      final bloc = getArtistSongsBloc(
        getArtistSongs: getArtistSongs,
        getArtistVideoLessons: getArtistVideoLessons,
        getAlphabeticalPrefixesList: getAlphabeticalPrefixesList,
      );

      when(() => getArtistSongs.call(artistUrl: any(named: "artistUrl"), filter: any(named: "filter")))
          .thenAnswer((_) => Future.value(Err(ServerError())));

      when(() => getArtistVideoLessons.call(any())).thenAnswer((_) => Future.value(Ok(videoLessons)));
      when(() => getAlphabeticalPrefixesList.call(any())).thenReturn(prefixes);

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
      when(() => getArtistSongs.call(artistUrl: any(named: "artistUrl"), filter: any(named: "filter")))
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
                    .having((state) => state.alphabeticalPrefixes, "prefixes", ["A", ""]),
              ]);
    });
  });

  group("If songs and video lessons have been successfully gotten", () {
    final getArtistSongsFilteredBySearch = _GetArtistSongsFilteredBySearch();
    final getArtistVideoLessons = _GetArtistVideoLessons();
    final getArtistSongs = _GetArtistSongs();
    final songs = [getFakeArtistSong(), getFakeArtistSong()];
    final videoLessons = [getFakeVideoLessons(), getFakeVideoLessons()];
    final prefixes = ["1", "2"];
    final getAlphabeticalPrefixesList = _GetAlphabeticalPrefixesList();

    when(() => getAlphabeticalPrefixesList.call(any())).thenReturn(prefixes);
    when(() => getArtistVideoLessons.call(any())).thenAnswer((_) => Future.value(Ok(videoLessons)));
    when(() => getArtistSongs.call(artistUrl: any(named: "artistUrl"), filter: any(named: "filter")))
        .thenAnswer((_) => Future.value(Ok(songs)));
    when(() =>
            getArtistSongsFilteredBySearch.call(searchString: any(named: "searchString"), songs: any(named: "songs")))
        .thenAnswer((_) => (songs, prefixes));

    var bloc = getArtistSongsBloc(
      getAlphabeticalPrefixesList: getAlphabeticalPrefixesList,
      getArtistSongs: getArtistSongs,
      getArtistSongsFilteredBySearch: getArtistSongsFilteredBySearch,
      getArtistVideoLessons: getArtistVideoLessons,
    );
    blocTest("The search bar should be visible",
        build: () => bloc,
        act: (bloc) async {
          await bloc.init();
          bloc.onPageChange(ArtistSongsPage.mostAccessed);
          bloc.onPageChange(ArtistSongsPage.alphabeticalOrder);
          bloc.onPageChange(ArtistSongsPage.videoLessons);
        },
        expect: () => [
              isA<ArtistSongsState>()
                  .having((state) => (state.shouldShowSearch, state.isLoading), "shouldShowSearch", (false, true)),
              isA<ArtistSongsState>()
                  .having((state) => (state.shouldShowSearch, state.isLoading), "shouldShowSearch", (true, false)),
            ]);
  });

  group("If songs have been successfully gotten, but not the video lessons", () {
    final getArtistSongsFilteredBySearch = _GetArtistSongsFilteredBySearch();
    final getArtistVideoLessons = _GetArtistVideoLessons();
    final getArtistSongs = _GetArtistSongs();
    final songs = [getFakeArtistSong(), getFakeArtistSong()];
    final prefixes = ["1", "2"];
    final getAlphabeticalPrefixesList = _GetAlphabeticalPrefixesList();

    when(() => getAlphabeticalPrefixesList.call(any())).thenReturn(prefixes);
    when(() => getArtistVideoLessons.call(any())).thenAnswer((_) => Future.value(Err(ServerError())));
    when(() => getArtistSongs.call(artistUrl: any(named: "artistUrl"), filter: any(named: "filter")))
        .thenAnswer((_) => Future.value(Ok(songs)));

    when(() =>
            getArtistSongsFilteredBySearch.call(searchString: any(named: "searchString"), songs: any(named: "songs")))
        .thenAnswer((_) => (songs, prefixes));
    var bloc = getArtistSongsBloc(
      getAlphabeticalPrefixesList: getAlphabeticalPrefixesList,
      getArtistSongs: getArtistSongs,
      getArtistSongsFilteredBySearch: getArtistSongsFilteredBySearch,
      getArtistVideoLessons: getArtistVideoLessons,
    );
    blocTest("The search bar should be visible only in songs tabs.",
        build: () => bloc,
        act: (bloc) async {
          await bloc.init();
          bloc.onPageChange(ArtistSongsPage.mostAccessed);
          bloc.onPageChange(ArtistSongsPage.alphabeticalOrder);
          bloc.onPageChange(ArtistSongsPage.videoLessons);
        },
        expect: () => [
              isA<ArtistSongsState>()
                  .having((state) => (state.shouldShowSearch, state.isLoading), "shouldShowSearch", (false, true)),
              isA<ArtistSongsState>()
                  .having((state) => (state.shouldShowSearch, state.isLoading), "shouldShowSearch", (true, false)),
              isA<ArtistSongsState>()
                  .having((state) => (state.shouldShowSearch, state.isLoading), "shouldShowSearch", (false, false)),
            ]);
  });

  group("If video lessons have been successfully gotten, but not the songs", () {
    final getArtistSongsFilteredBySearch = _GetArtistSongsFilteredBySearch();
    final getArtistVideoLessons = _GetArtistVideoLessons();
    final getArtistSongs = _GetArtistSongs();
    final prefixes = ["1", "2"];
    final videoLessons = [getFakeVideoLessons(), getFakeVideoLessons()];
    final getAlphabeticalPrefixesList = _GetAlphabeticalPrefixesList();

    when(() => getAlphabeticalPrefixesList.call(any())).thenReturn(prefixes);
    when(() => getArtistVideoLessons.call(any())).thenAnswer((_) => Future.value(Ok(videoLessons)));
    when(() => getArtistSongs.call(
          artistUrl: any(named: "artistUrl"),
          filter: any(named: "filter"),
        )).thenAnswer((_) => Future.value(Err(ServerError())));

    when(() => getArtistSongsFilteredBySearch.call(
          searchString: any(named: "searchString"),
          songs: any(named: "songs"),
        )).thenAnswer((_) => ([], []));
    var bloc = getArtistSongsBloc(
      getAlphabeticalPrefixesList: getAlphabeticalPrefixesList,
      getArtistSongs: getArtistSongs,
      getArtistSongsFilteredBySearch: getArtistSongsFilteredBySearch,
      getArtistVideoLessons: getArtistVideoLessons,
    );
    blocTest("The search bar should be visible only in video lessons tab.",
        build: () => bloc,
        act: (bloc) async {
          await bloc.init();
          bloc.onPageChange(ArtistSongsPage.mostAccessed);
          bloc.onPageChange(ArtistSongsPage.alphabeticalOrder);
          bloc.onPageChange(ArtistSongsPage.videoLessons);
        },
        expect: () => [
              isA<ArtistSongsState>()
                  .having((state) => (state.shouldShowSearch, state.isLoading), "shouldShowSearch", (false, true)),
              isA<ArtistSongsState>()
                  .having((state) => (state.shouldShowSearch, state.isLoading), "shouldShowSearch", (false, false)),
              isA<ArtistSongsState>()
                  .having((state) => (state.shouldShowSearch, state.isLoading), "shouldShowSearch", (true, false)),
            ]);
  });

  group("when onSearchStringChanged is called", () {
    final getArtistSongsFilteredBySearch = _GetArtistSongsFilteredBySearch();
    final getAlphabeticalPrefixesList = _GetAlphabeticalPrefixesList();
    final getArtistSongs = _GetArtistSongs();

    final songs = [getFakeArtistSong(), getFakeArtistSong()];
    final alphabeticalPrefixes = ["A", ""];
    final prefixes = ["1", "2"];

    when(() => getAlphabeticalPrefixesList.call(any())).thenReturn(alphabeticalPrefixes);

    when(() =>
            getArtistSongsFilteredBySearch.call(searchString: any(named: "searchString"), songs: any(named: "songs")))
        .thenAnswer((_) => (songs, prefixes));

    when(() => getArtistSongs.call(
          artistUrl: any(named: "artistUrl"),
          filter: any(named: "filter"),
        )).thenAnswer((_) => Future.value(Err(ServerError())));

    final bloc = getArtistSongsBloc(
      getArtistSongsFilteredBySearch: getArtistSongsFilteredBySearch,
      getAlphabeticalPrefixesList: getAlphabeticalPrefixesList,
      getArtistSongs: getArtistSongs,
    );

    blocTest("should emit state with correctly filtered songs",
        build: () => bloc,
        act: (bloc) async {
          bloc.onSearchStringChanged("a");
          bloc.onSearchStringChanged("a ");
          bloc.onSearchStringChanged(" a ");
        },
        expect: () => [
              isA<ArtistSongsState>().having(
                (state) => (state.songsFilteredBySearch, state.rankingPrefixes),
                "",
                (songs, prefixes),
              ),
            ]);
  });

  group("when onSearchStringChanged is called", () {
    final getArtistSongsFilteredBySearch = _GetArtistSongsFilteredBySearch();
    final getAlphabeticalPrefixesList = _GetAlphabeticalPrefixesList();
    final getArtistVideoLessons = _GetArtistVideoLessons();
    final getArtistSongs = _GetArtistSongs();

    final songs = [getFakeArtistSong(), getFakeArtistSong()];
    final alphabeticalPrefixes = ["A", ""];
    final prefixes = ["1", "2"];
    final videoLessons = [getFakeVideoLessons(title: "Abc"), getFakeVideoLessons(title: "bcd")];

    when(() => getAlphabeticalPrefixesList.call(any())).thenReturn(alphabeticalPrefixes);

    when(() =>
            getArtistSongsFilteredBySearch.call(searchString: any(named: "searchString"), songs: any(named: "songs")))
        .thenAnswer((_) => (songs, prefixes));

    when(() => getArtistVideoLessons.call(any())).thenAnswer((_) => Future.value(Ok(videoLessons)));

    when(() => getArtistSongs.call(
          artistUrl: any(named: "artistUrl"),
          filter: any(named: "filter"),
        )).thenAnswer((_) => Future.value(Err(ServerError())));

    final bloc = getArtistSongsBloc(
      getArtistSongsFilteredBySearch: getArtistSongsFilteredBySearch,
      getAlphabeticalPrefixesList: getAlphabeticalPrefixesList,
      getArtistVideoLessons: getArtistVideoLessons,
      getArtistSongs: getArtistSongs,
    );

    blocTest("should emit state with correctly filtered videolessons",
        build: () => bloc,
        act: (bloc) async {
          await bloc.init();
          bloc.onSearchStringChanged("a");
          bloc.onSearchStringChanged("a ");
          bloc.onSearchStringChanged(" a ");
        },
        expect: () => [
              isA<ArtistSongsState>().having((state) => state.isLoading, "", true),
              isA<ArtistSongsState>().having((state) => state.isLoading, "", false),
              isA<ArtistSongsState>().having((state) => state.videoLessonsFilteredBySearch, "", [videoLessons.first]),
            ]);
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
                  .having((state) => state.alphabeticalPrefixes, "prefixes", ["A", ""])
            ]);
  });
}
