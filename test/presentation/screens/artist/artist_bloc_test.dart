import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/artist/models/artist_song_filter.dart';
import 'package:cifraclub/domain/artist/use_cases/favorite_unfavorite_artist.dart';
import 'package:cifraclub/domain/artist/use_cases/get_albums.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_info.dart';
import 'package:cifraclub/domain/artist/use_cases/get_artist_songs.dart';
import 'package:cifraclub/domain/artist/use_cases/get_default_instruments.dart';
import 'package:cifraclub/domain/artist/use_cases/get_filtered_artist_songs.dart';
import 'package:cifraclub/domain/artist/use_cases/get_is_artist_fan.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/screens/artist/artist_bloc.dart';
import 'package:cifraclub/presentation/screens/artist/artist_event.dart';
import 'package:cifraclub/presentation/screens/artist/artist_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/artist/models/album_mock.dart';
import '../../../shared_mocks/domain/artist/models/artist_info_mock.dart';
import '../../../shared_mocks/domain/artist/models/artist_song_mock.dart';

class _GetArtistSongsMock extends Mock implements GetArtistSongs {}

class _GetArtistInfoMock extends Mock implements GetArtistInfo {}

class _GetAlbumsMock extends Mock implements GetAlbums {}

class _GetDefaultInstrumentsMock extends Mock implements GetDefaultInstruments {}

class _GetFilteredArtistSongsMock extends Mock implements GetFilteredArtistSongs {}

class _GetIsArtistFanMock extends Mock implements GetIsArtistFan {}

class _FavoriteArtistMock extends Mock implements FavoriteUnfavoriteArtist {}

class _OpenLoginPageMock extends Mock implements OpenLoginPage {
  static _OpenLoginPageMock newDummy() {
    final mock = _OpenLoginPageMock();
    when(mock.call).thenAnswer((_) => SynchronousFuture(null));
    return mock;
  }
}

class _GetCredentialStreamMock extends Mock implements GetCredentialStream {
  _GetCredentialStreamMock([
    UserCredential credentials = const UserCredential(isUserLoggedIn: false, user: null),
  ]) {
    when(call).thenAnswer((_) => BehaviorSubject.seeded(credentials));
  }
}

void main() {
  ArtistBloc getArtistBloc({
    String? artistUrl,
    _GetArtistInfoMock? getArtistInfo,
    _GetArtistSongsMock? getArtistSongs,
    _GetAlbumsMock? getAlbums,
    _GetDefaultInstrumentsMock? getDefaultInstruments,
    _GetFilteredArtistSongsMock? getFilteredArtistSongs,
    _GetIsArtistFanMock? getIsArtistFan,
    _FavoriteArtistMock? favoriteArtist,
    _GetCredentialStreamMock? getCredentialStream,
    _OpenLoginPageMock? openLoginPage,
  }) =>
      ArtistBloc(
        artistUrl ?? "",
        getArtistSongs ?? _GetArtistSongsMock(),
        getArtistInfo ?? _GetArtistInfoMock(),
        getAlbums ?? _GetAlbumsMock(),
        getDefaultInstruments ?? _GetDefaultInstrumentsMock(),
        getFilteredArtistSongs ?? _GetFilteredArtistSongsMock(),
        getIsArtistFan ?? _GetIsArtistFanMock(),
        favoriteArtist ?? _FavoriteArtistMock(),
        getCredentialStream ?? _GetCredentialStreamMock(),
        openLoginPage ?? _OpenLoginPageMock.newDummy(),
      );

  group("when init is called", () {
    test("should initialize all use cases", () async {
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
      final getCredentialStream = _GetCredentialStreamMock();
      final getIsArtistFan = _GetIsArtistFanMock();

      when(() => getDefaultInstruments.call(any())).thenAnswer(
        (_) => Future.value(
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

      when(() => getArtistSongs(artistUrl: any(named: "artistUrl"), filter: any(named: "filter"))).thenAnswer(
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

      final bloc = getArtistBloc(
          getArtistInfo: getArtistInfo,
          getAlbums: getArtistAlbums,
          getArtistSongs: getArtistSongs,
          getCredentialStream: getCredentialStream,
          getDefaultInstruments: getDefaultInstruments,
          getIsArtistFan: getIsArtistFan);

      await bloc.init();

      verify(() => getArtistAlbums.call(any())).called(1);
      verify(() => getArtistSongs(artistUrl: any(named: "artistUrl"), filter: ArtistSongFilter.cifra)).called(1);
      verify(() => getArtistInfo(any())).called(1);
      verify(getCredentialStream).called(1);
      verify(() => getDefaultInstruments(any())).called(1);
    });
  });

  group("When fetchArtistInfo is called", () {
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

      when(() => getArtistSongs(artistUrl: any(named: "artistUrl"), filter: any(named: "filter"))).thenAnswer(
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
        act: (bloc) => bloc.fetchArtistInfo(),
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

      when(() => getArtistSongs.call(artistUrl: any(named: "artistUrl"), filter: any(named: "filter"))).thenAnswer(
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
        act: (bloc) => bloc.fetchArtistInfo(),
        expect: () => [
          isA<ArtistState>().having((state) => state.isLoading, "isLoading", true),
          isA<ArtistState>()
              .having((state) => state.error, "error", error)
              .having((state) => state.isLoading, "isLoading", false)
        ],
      );
    });
  });

  group("when initSubscriptions is called", () {
    group("should listen to user credential stream", () {
      final getCredentialStream = _GetCredentialStreamMock();
      final getIsArtistFan = _GetIsArtistFanMock();
      const user = User(id: 123);

      when(getCredentialStream).thenAnswer((invocation) => BehaviorSubject<UserCredential>()
        ..addStream(Stream.fromIterable(const [
          UserCredential(isUserLoggedIn: false, user: null),
          UserCredential(isUserLoggedIn: true, user: user),
        ])));

      when(() => getIsArtistFan(artistUrl: any(named: "artistUrl"), userId: any(named: "userId")))
          .thenAnswer((_) => SynchronousFuture(const Ok(true)));

      blocTest(
        "should update user and isFavorite state",
        build: () => getArtistBloc(getCredentialStream: getCredentialStream, getIsArtistFan: getIsArtistFan),
        act: (bloc) => bloc.initSubscriptions(),
        expect: () => [
          isA<ArtistState>()
              .having((state) => state.user, "user", null)
              .having((state) => state.isFavorite, "isFavorite", false),
          isA<ArtistState>()
              .having((state) => state.user, "user", user)
              .having((state) => state.isFavorite, "isFavorite", true),
        ],
      );
    });
  });

  group("should listen to favorite stream", () {
    final favoriteArtist = _FavoriteArtistMock();
    final getIsArtistFan = _GetIsArtistFanMock();
    when(() => favoriteArtist(artistUrl: any(named: "artistUrl"), isFavorite: any(named: "isFavorite"))).thenAnswer(
      (_) => SynchronousFuture(const Ok(null)),
    );

    blocTest(
      "when favoriteUnfavorite is success, should update isFavorite state",
      build: () => getArtistBloc(favoriteArtist: favoriteArtist, getIsArtistFan: getIsArtistFan),
      act: (bloc) async {
        bloc.initSubscriptions();
        bloc.onFavorite();
        await Future.delayed(const Duration(milliseconds: 400));
        bloc.onFavorite();
        await Future.delayed(const Duration(milliseconds: 400));
      },
      expect: () => [
        isA<ArtistState>().having((state) => state.isFavorite, "isFavorite", false),
        isA<ArtistState>().having((state) => state.isFavorite, "isFavorite", true),
        isA<ArtistState>().having((state) => state.isFavorite, "isFavorite", false),
      ],
    );
  });

  test("when favoriteUnfavorite is error should send FavoriteError event", () async {
    final favoriteArtist = _FavoriteArtistMock();
    when(() => favoriteArtist(artistUrl: any(named: "artistUrl"), isFavorite: any(named: "isFavorite"))).thenAnswer(
      (_) => SynchronousFuture(Err(ServerError())),
    );

    final bloc = getArtistBloc(favoriteArtist: favoriteArtist);
    bloc.initSubscriptions();
    bloc.onFavorite();
    final event = await bloc.artistEventStream.first;

    expect(event, isA<FavoriteError>());
  });

  group("when onInstrumentSelected is called", () {
    final getFilteredArtistSongs = _GetFilteredArtistSongsMock();
    final artistSongs = [getFakeArtistSong(), getFakeArtistSong()];

    when(() => getFilteredArtistSongs.call([], Instrument.bass)).thenAnswer(
      (invocation) => SynchronousFuture(artistSongs),
    );

    blocTest(
      "should emit state with selected instrument and fetch filtered songs",
      build: () => getArtistBloc(getFilteredArtistSongs: getFilteredArtistSongs),
      act: (bloc) => bloc.onInstrumentSelected(Instrument.bass),
      expect: () => [
        isA<ArtistState>().having((state) => state.selectedInstrument, "selected instrument", Instrument.bass),
        isA<ArtistState>().having((state) => state.songs, "filtered songs", artistSongs),
      ],
    );
  });

  test("When openLoginPage is called should call openLoginPage use case", () async {
    final openLoginPage = _OpenLoginPageMock.newDummy();

    final bloc = getArtistBloc(openLoginPage: openLoginPage);
    bloc.openLoginPage();
    verify(openLoginPage).called(1);
  });
}
