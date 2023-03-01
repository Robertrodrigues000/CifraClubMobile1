import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart';
import 'package:cifraclub/domain/home/use_cases/get_home_info.dart';
import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/logout.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/domain/user/use_cases/open_user_profile_page.dart';
import 'package:cifraclub/presentation/screens/home/home_bloc.dart';
import 'package:cifraclub/presentation/screens/home/home_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

class _LogoutMock extends Mock implements Logout {
  static Logout newDummy() {
    final mock = _LogoutMock();
    when(mock.call).thenAnswer((_) => SynchronousFuture(null));
    return mock;
  }
}

class _OpenLoginPageMock extends Mock implements OpenLoginPage {
  static OpenLoginPage newDummy() {
    final mock = _OpenLoginPageMock();
    when(mock.call).thenAnswer((_) => SynchronousFuture(null));
    return mock;
  }
}

class _OpenUserProfileMock extends Mock implements OpenUserProfilePage {
  static OpenUserProfilePage newDummy() {
    final mock = _OpenUserProfileMock();
    when(mock.call).thenAnswer((_) => SynchronousFuture(null));
    return mock;
  }
}

class _GetCredentialStreamMock extends Mock implements GetCredentialStream {
  static GetCredentialStream newDummy(
      [UserCredential credentials = const UserCredential(isUserLoggedIn: false, user: null)]) {
    final mock = _GetCredentialStreamMock();
    when(mock.call).thenAnswer((_) => BehaviorSubject.seeded(credentials));
    return mock;
  }
}

class _GetUserGenresAsStreamMock extends Mock implements GetUserGenresAsStream {}

class _GetHomeInfoMock extends Mock implements GetHomeInfo {}

void main() {
  HomeBloc getHomeBloc({
    GetCredentialStream? getCredentialStream,
  }) =>
      HomeBloc(
        _GetUserGenresAsStreamMock(),
        getCredentialStream ?? _GetCredentialStreamMock.newDummy(),
        _OpenLoginPageMock.newDummy(),
        _OpenUserProfileMock.newDummy(),
        _LogoutMock.newDummy(),
        _GetHomeInfoMock(),
      );

  group("When user selection profile action, ", () {
    blocTest(
      "should show login page",
      build: getHomeBloc,
      act: (bloc) => bloc.openLoginPage(),
      verify: (bloc) {
        verify(bloc.openLoginPage).called(1);
      },
    );

    blocTest(
      "should show profile page",
      build: getHomeBloc,
      act: (bloc) => bloc.openProfilePage(),
      verify: (bloc) {
        verify(bloc.openProfilePage).called(1);
      },
    );

    blocTest(
      "should show logout user",
      build: getHomeBloc,
      act: (bloc) => bloc.logoutUser(),
      verify: (bloc) {
        verify(bloc.logoutUser).called(1);
      },
    );
  });

  group("When get user credentials, ", () {
    UserCredential userCredential = const UserCredential(isUserLoggedIn: true, user: User(name: "Arthur"));

    GetCredentialStream credentialStream = _GetCredentialStreamMock.newDummy(userCredential);
    final bloc = getHomeBloc(getCredentialStream: credentialStream);

    blocTest(
      "should emit null user",
      build: getHomeBloc,
      act: (bloc) => bloc.getUserInfo(),
      expect: () => [
        isA<HomeLoadingState>().having((state) => state.user, "user null", null),
      ],
    );

    blocTest(
      "should emit user infos",
      build: () => bloc,
      act: (bloc) => bloc.getUserInfo(),
      expect: () => [
        isA<HomeLoadingState>().having((state) => state.user, "user credentials", userCredential.user),
      ],
    );
  });
}
