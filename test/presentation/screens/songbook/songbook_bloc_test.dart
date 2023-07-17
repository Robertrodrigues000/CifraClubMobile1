import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/user/use_cases/open_login_page.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import '../../../shared_mocks/domain/songbook/models/songbook_mock.dart';

class _OpenLoginPageMock extends Mock implements OpenLoginPage {}

class _GetCredentialStreamMock extends Mock implements GetCredentialStream {}

void main() {
  group("When init is called, ", () {
    // ignore: close_sinks
    BehaviorSubject<UserCredential> credentialStream =
        BehaviorSubject.seeded(const UserCredential(isUserLoggedIn: false));

    GetCredentialStream getCredentialStream = _GetCredentialStreamMock();
    when(() => getCredentialStream()).thenAnswer((_) => credentialStream);

    final bloc = SongbookBloc(getCredentialStream, _OpenLoginPageMock());

    blocTest(
      "should update state with user from use case",
      build: () => bloc,
      act: (bloc) {
        bloc.init();
        credentialStream.add(const UserCredential(isUserLoggedIn: true));
      },
      verify: (bloc) => expect(bloc.state.userCredential?.isUserLoggedIn, true),
    );
  });

  group("When open login page is called", () {
    OpenLoginPage openLoginPage = _OpenLoginPageMock();

    when(() => openLoginPage.call()).thenAnswer((_) => SynchronousFuture(null));

    blocTest(
      "should call open login page use case",
      build: () => SongbookBloc(
        _GetCredentialStreamMock(),
        openLoginPage,
      ),
      act: (bloc) {
        bloc.openLoginPage();
      },
      verify: (bloc) {
        verify(() => openLoginPage()).called(1);
      },
    );
  });

  group("When songbook change", () {
    final bloc = SongbookBloc(
      _GetCredentialStreamMock(),
      _OpenLoginPageMock(),
    );
    final songbook = getFakeSongbook();

    blocTest("should emit a new songbook",
        build: () => bloc,
        act: (bloc) => bloc.onSelectSongbook(songbook.id),
        expect: () => [isA<SongbookState>().having((state) => state.selectedSongbookId, "songbook id", songbook.id)]);
  });
}
