import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/songbook/models/songbook_version_input_mock.dart';
import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _SongbookRepositoryMock extends Mock implements SongbookRepository {}

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

class _UserSongbookRepository extends Mock implements UserSongbookRepository {}

void main() {
  late _UserVersionRepositoryMock userVersionRepository;
  late _SongbookRepositoryMock songbookRepository;
  late _UserSongbookRepository userSongbookRepository;

  setUp(() {
    userVersionRepository = _UserVersionRepositoryMock();
    songbookRepository = _SongbookRepositoryMock();
    userSongbookRepository = _UserSongbookRepository();
  });

  test("When call use case and request is success should save in local DB", () async {
    final version = getFakeVersion();
    final versionInput = getFakeSongbookVersionInput();
    final versionResponse = getFakeVersion();

    when(() => songbookRepository.addVersionToSongbook(songbookId: 10, versionInput: versionInput))
        .thenAnswer((_) => SynchronousFuture(Ok(versionResponse)));

    when(() => userVersionRepository.addVersionsToSongbook([versionResponse], 10))
        .thenAnswer((_) => SynchronousFuture([version.localDatabaseID!]));

    when(() => userSongbookRepository.incrementTotalSongs(
        songbookId: any(named: "songbookId"),
        quantity: any(named: "quantity"))).thenAnswer((_) => SynchronousFuture(1));

    final result = await InsertVersionToSongbook(songbookRepository, userVersionRepository, userSongbookRepository)(
        versionInput: versionInput, songbookId: 10);

    verify(() => userVersionRepository.addVersionsToSongbook([versionResponse], 10)).called(1);
    verify(() => songbookRepository.addVersionToSongbook(versionInput: versionInput, songbookId: 10)).called(1);
    verify(() => userSongbookRepository.incrementTotalSongs(
        songbookId: any(named: "songbookId"), quantity: any(named: "quantity"))).called(1);
    expectLater(result.get(), versionResponse);
  });

  test("When call use case and request fails should return result error", () async {
    final versionInput = getFakeSongbookVersionInput();

    when(() => songbookRepository.addVersionToSongbook(songbookId: 10, versionInput: versionInput))
        .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    when(() => userSongbookRepository.incrementTotalSongs(
        songbookId: any(named: "songbookId"),
        quantity: any(named: "quantity"))).thenAnswer((_) => SynchronousFuture(null));

    final result = await InsertVersionToSongbook(songbookRepository, userVersionRepository, userSongbookRepository)(
        versionInput: versionInput, songbookId: 10);

    verifyNever(() => userVersionRepository.addVersionsToSongbook(any(), any()));
    verify(() => songbookRepository.addVersionToSongbook(versionInput: versionInput, songbookId: 10)).called(1);
    verifyNever(() => userSongbookRepository.incrementTotalSongs(
        songbookId: any(named: "songbookId"), quantity: any(named: "quantity")));
    expectLater(result.getError(), isA<ServerError>());
  });
}
