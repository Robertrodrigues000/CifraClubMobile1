import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_versions_to_songbook.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _UserVersionsRepository extends Mock implements UserVersionRepository {}

class _SongbookRepository extends Mock implements SongbookRepository {}

class _UserSongbookRepository extends Mock implements UserSongbookRepository {}

void main() {
  late _UserVersionsRepository userVersionRepository;
  late _SongbookRepository songbookRepository;
  late _UserSongbookRepository userSongbookRepository;

  setUp(() {
    userVersionRepository = _UserVersionsRepository();
    songbookRepository = _SongbookRepository();
    userSongbookRepository = _UserSongbookRepository();
  });

  test("When call use case and request is successful should return songs and add to local db", () async {
    final songs = [getFakeVersion()];
    when(() => userVersionRepository.deleteVersionsBySongbookId(1)).thenAnswer((_) => SynchronousFuture(1));
    when(() => userVersionRepository.addVersionsToSongbook(songs, 1))
        .thenAnswer((_) => SynchronousFuture([songs.first.localDatabaseID!]));
    when(() => songbookRepository.addVersionsToSongbook(versionsInput: any(named: "versionsInput"), songbookId: 1))
        .thenAnswer((_) => SynchronousFuture(Ok(songs)));

    when(() => userSongbookRepository.incrementTotalSongs(
        songbookId: any(named: "songbookId"),
        quantity: any(named: "quantity"))).thenAnswer((_) => SynchronousFuture(1));

    final result = await InsertVersionsToSongbook(songbookRepository, userVersionRepository, userSongbookRepository)(
        songbookId: 1, versions: songs);

    expect(result.get(), songs);

    verify(() => userVersionRepository.deleteVersionsBySongbookId(1)).called(1);
    verify(() => userVersionRepository.addVersionsToSongbook(songs, 1)).called(1);
    verify(() => userSongbookRepository.incrementTotalSongs(
        songbookId: any(named: "songbookId"), quantity: any(named: "quantity"))).called(1);
  });

  test("When call use case and request fails should return request error", () async {
    final songs = [getFakeVersion()];
    when(() => songbookRepository.addVersionsToSongbook(versionsInput: any(named: "versionsInput"), songbookId: 1))
        .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    when(() => userSongbookRepository.incrementTotalSongs(
        songbookId: any(named: "songbookId"),
        quantity: any(named: "quantity"))).thenAnswer((_) => SynchronousFuture(null));

    final result = await InsertVersionsToSongbook(songbookRepository, userVersionRepository, userSongbookRepository)(
        songbookId: 1, versions: songs);

    expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "status code", 404));

    verifyNever(() => userVersionRepository.deleteVersionsBySongbookId(any()));
    verifyNever(() => userVersionRepository.addVersionsToSongbook(any(), any()));
    verifyNever(() => userSongbookRepository.incrementTotalSongs(
        songbookId: any(named: "songbookId"), quantity: any(named: "quantity")));
  });
}
