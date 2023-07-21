import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_user_songbooks_on_logout.dart';
import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential_stream.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

class _UserSongbookRepositoryMock extends Mock implements UserSongbookRepository {}

class _GetCredentialStreamMock extends Mock implements GetCredentialStream {}

void main() {
  late _UserVersionRepositoryMock userVersionRepository;
  late _UserSongbookRepositoryMock songbookRepository;
  late _GetCredentialStreamMock getCredentialStream;

  setUp(() {
    userVersionRepository = _UserVersionRepositoryMock();
    songbookRepository = _UserSongbookRepositoryMock();
    getCredentialStream = _GetCredentialStreamMock();
  });

  test("when user logout should clear songbooks and versions", () async {
    when(getCredentialStream).thenAnswer((_) => BehaviorSubject<UserCredential>()
      ..addStream(BehaviorSubject<UserCredential>()
        ..addStream(Stream.fromIterable(const [
          UserCredential(isUserLoggedIn: false, user: null),
          UserCredential(isUserLoggedIn: true, user: User()),
          UserCredential(isUserLoggedIn: false, user: null)
        ]))));

    when(userVersionRepository.clearAllVersions).thenAnswer((_) => SynchronousFuture(null));
    when(songbookRepository.deleteAll).thenAnswer((_) => SynchronousFuture(null));

    final clearUserSongbooksOnLogout =
        ClearUserSongbooksOnLogout(songbookRepository, userVersionRepository, getCredentialStream);

    clearUserSongbooksOnLogout();

    await Future.delayed(Duration.zero);

    verify(getCredentialStream).called(1);
    verify(userVersionRepository.clearAllVersions).called(1);
    verify(songbookRepository.deleteAll).called(1);
  });
}
