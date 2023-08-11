import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_versions.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _UserCifraRepository extends Mock implements UserVersionRepository {}

class _SongbookRepository extends Mock implements SongbookRepository {}

class _UserSongbookRepository extends Mock implements UserSongbookRepository {}

void main() {
  late _UserCifraRepository userCifraRepository;
  late _SongbookRepository songbookRepository;
  late _UserSongbookRepository userSongbookRepository;

  setUp(() {
    userCifraRepository = _UserCifraRepository();
    songbookRepository = _SongbookRepository();
    userSongbookRepository = _UserSongbookRepository();
  });

  test("When call use case and request is successful should remove songs of local db", () async {
    final songs = [getFakeVersion()];
    when(() => songbookRepository.deleteVersions(songbookId: 1, versionsId: [songs.first.remoteDatabaseId!]))
        .thenAnswer((_) => Future.value(const Ok(null)));
    when(() => userCifraRepository.deleteVersionsById([songs.first.localDatabaseId!]))
        .thenAnswer((invocation) => SynchronousFuture(1));

    when(() => userSongbookRepository.decrementTotalSongs(
        songbookId: any(named: "songbookId"),
        quantity: any(named: "quantity"))).thenAnswer((_) => SynchronousFuture(1));

    final result = await DeleteVersions(songbookRepository, userCifraRepository, userSongbookRepository)(
        songbookId: 1, versions: songs);

    expect(result.isSuccess, isTrue);

    verify(() => userCifraRepository.deleteVersionsById([songs.first.localDatabaseId!])).called(1);
    verify(() => userSongbookRepository.decrementTotalSongs(
        songbookId: any(named: "songbookId"), quantity: any(named: "quantity"))).called(1);
  });

  test("When call use case and request fails should return request error", () async {
    final songs = [getFakeVersion()];
    when(() => songbookRepository.deleteVersions(versionsId: [songs.first.remoteDatabaseId!], songbookId: 1))
        .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    when(() => userSongbookRepository.decrementTotalSongs(songbookId: 1))
        .thenAnswer((invocation) => SynchronousFuture(1));

    final result = await DeleteVersions(songbookRepository, userCifraRepository, userSongbookRepository)(
        songbookId: 1, versions: songs);

    expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "status code", 404));

    verifyNever(() => userCifraRepository.deleteVersionsById(any()));
    verifyNever(() => userSongbookRepository.decrementTotalSongs(
        songbookId: any(named: "songbookId"), quantity: any(named: "quantity")));
  });
}
