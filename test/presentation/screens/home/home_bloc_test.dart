import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart';
import 'package:cifraclub/domain/home/models/home_info.dart';
import 'package:cifraclub/domain/home/use_cases/get_home_info.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/logout.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart';
import 'package:cifraclub/presentation/screens/home/home_bloc.dart';
import 'package:cifraclub/presentation/screens/home/home_state/home_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/artist/models/artist_mock.dart';
import '../../../shared_mocks/domain/genre/models/genre_mock.dart';
import '../../../shared_mocks/domain/home/models/highlight_mock.dart';
import '../../../shared_mocks/domain/home/models/news_mock.dart';
import '../../../shared_mocks/domain/home/models/video_lessons_mock.dart';
import '../../../shared_mocks/domain/song/models/song_mock.dart';

class _LogoutMock extends Mock implements Logout {
  static _LogoutMock newDummy() {
    final mock = _LogoutMock();
    when(mock.call).thenAnswer((_) => SynchronousFuture(null));
    return mock;
  }
}

class _OpenLoginPageMock extends Mock implements OpenLoginPage {
  static _OpenLoginPageMock newDummy() {
    final mock = _OpenLoginPageMock();
    when(mock.call).thenAnswer((_) => SynchronousFuture(null));
    return mock;
  }
}

class _OpenUserProfileMock extends Mock implements OpenUserProfilePage {
  static _OpenUserProfileMock newDummy() {
    final mock = _OpenUserProfileMock();
    when(mock.call).thenAnswer((_) => SynchronousFuture(null));
    return mock;
  }
}

class _GetCredentialStreamMock extends Mock implements GetCredentialStream {
  static _GetCredentialStreamMock newDummy(
      [UserCredential credentials = const UserCredential(isUserLoggedIn: false, user: null)]) {
    final mock = _GetCredentialStreamMock();
    when(mock.call).thenAnswer((_) => BehaviorSubject.seeded(credentials));
    return mock;
  }
}

class _GetUserGenresAsStreamMock extends Mock implements GetUserGenresAsStream {
  static _GetUserGenresAsStreamMock newDummy({List<Genre> genres = const []}) {
    final mock = _GetUserGenresAsStreamMock();
    when(mock.call).thenAnswer((_) => BehaviorSubject.seeded(genres));
    return mock;
  }
}

class _GetHomeInfoMock extends Mock implements GetHomeInfo {}

void main() {
  HomeBloc getHomeBloc({
    _GetUserGenresAsStreamMock? getUserGenresAsStream,
    _GetCredentialStreamMock? getCredentialStream,
    _OpenLoginPageMock? openLoginPage,
    _OpenUserProfileMock? openUserProfile,
    _LogoutMock? logout,
    _GetHomeInfoMock? getHomeInfo,
  }) =>
      HomeBloc(
        getUserGenresAsStream ?? _GetUserGenresAsStreamMock(),
        getCredentialStream ?? _GetCredentialStreamMock.newDummy(),
        openLoginPage ?? _OpenLoginPageMock.newDummy(),
        openUserProfile ?? _OpenUserProfileMock.newDummy(),
        logout ?? _LogoutMock.newDummy(),
        getHomeInfo ?? _GetHomeInfoMock(),
      );

  test("When user action is openLoginPage should call openLoginPage use case", () async {
    final openLoginPage = _OpenLoginPageMock.newDummy();

    final bloc = getHomeBloc(openLoginPage: openLoginPage);
    bloc.openLoginPage();
    verify(openLoginPage).called(1);
  });

  test("When user action is openUserProfile should call openUserProfile use case", () async {
    final openUserProfile = _OpenUserProfileMock.newDummy();

    final bloc = getHomeBloc(openUserProfile: openUserProfile);
    bloc.openProfilePage();
    verify(openUserProfile).called(1);
  });

  test("When user action is logoutUser should call logout use case", () async {
    final logout = _LogoutMock.newDummy();

    final bloc = getHomeBloc(logout: logout);
    bloc.logoutUser();
    verify(logout).called(1);
  });

  group("When get user credentials, ", () {
    UserCredential userCredential = const UserCredential(isUserLoggedIn: true, user: User(name: "Arthur"));

    final credentialStream = _GetCredentialStreamMock.newDummy(userCredential);
    final bloc = getHomeBloc(getCredentialStream: credentialStream);

    blocTest(
      "if user is logged out should emit null user",
      build: getHomeBloc,
      act: (bloc) => bloc.getUserInfo(),
      expect: () => [
        isA<HomeState>().having((state) => state.user, "user null", null),
      ],
    );

    blocTest(
      "if user is logged in should emit user infos",
      build: () => bloc,
      act: (bloc) => bloc.getUserInfo(),
      expect: () => [
        isA<HomeState>().having((state) => state.user, "user credentials", userCredential.user),
      ],
    );
  });

  group("When initGenres is called", () {
    final genres = [getFakeGenre(), getFakeGenre(), getFakeGenre(), getFakeGenre()];
    final userGenresAsStream = _GetUserGenresAsStreamMock.newDummy(genres: genres);

    final bloc = getHomeBloc(getUserGenresAsStream: userGenresAsStream);

    blocTest(
      "should update state with genres from use case",
      build: () => bloc,
      act: (bloc) => bloc.initGenres(),
      expect: () => [
        isA<HomeState>().having((state) => state.isLoading, "is Loading Genres", true),
        isA<HomeState>().having((state) => state.genres, "genres", genres),
      ],
    );
  });

  group("When onGenreSelected is called", () {
    test("should update de current state with selected genre and trigger requestHomeInfo", () {
      const selectedGenre = "MPB";
      final getHomeInfo = _GetHomeInfoMock();

      when(() => getHomeInfo(any())).thenAnswer((_) => SynchronousFuture(const Ok(
            HomeInfo(
              highlights: [],
              songs: [],
              artists: [],
              videoLessons: [],
              news: [],
            ),
          )));
      final bloc = getHomeBloc(getHomeInfo: getHomeInfo);

      bloc.onGenreSelected(selectedGenre);

      expect(bloc.state.selectedGenre, selectedGenre);
      verify(() => getHomeInfo(any())).called(1);
    });
  });

  group("when requestHomeInfo", () {
    group("is succesful", () {
      final getHomeInfo = _GetHomeInfoMock();
      final homeInfo = HomeInfo(
        highlights: [getFakeHighlight(), getFakeHighlight()],
        songs: [getFakeSong(), getFakeSong()],
        artists: [getFakeArtist(), getFakeArtist()],
        videoLessons: [getFakeVideoLessons(), getFakeVideoLessons()],
        news: [getFakeNews(), getFakeNews()],
      );
      when(() => getHomeInfo(any())).thenAnswer((_) => SynchronousFuture(Ok(homeInfo)));

      final bloc = getHomeBloc(getHomeInfo: getHomeInfo);
      blocTest(
        "should update state with home info",
        build: () => bloc,
        act: (bloc) => bloc.requestHomeData(),
        expect: () => [
          isA<HomeState>().having((state) => state.isLoading, "is loading", true),
          isA<HomeState>()
              .having((state) => state.isLoading, "is loading", false)
              .having((state) => state.highlights.length, "highlights", homeInfo.highlights!.length)
              .having((state) => state.topArtists.length, "topArtists", homeInfo.artists!.length)
              .having((state) => state.videoLessons.length, "videlessons", homeInfo.videoLessons!.length)
              .having((state) => state.blog.length, "blog", homeInfo.news!.length)
        ],
      );
    });

    group("fails", () {
      final getHomeInfo = _GetHomeInfoMock();
      when(() => getHomeInfo(any())).thenAnswer((invocation) => SynchronousFuture(Err(ServerError())));

      final bloc = getHomeBloc(getHomeInfo: getHomeInfo);
      blocTest(
        "should update state with error",
        build: () => bloc,
        act: (bloc) => bloc.requestHomeData(),
        expect: () => [
          isA<HomeState>().having((state) => state.isLoading, "is loading", true),
          isA<HomeState>().having((state) => state.error, "error", isNotNull),
        ],
      );
    });
  });
}
