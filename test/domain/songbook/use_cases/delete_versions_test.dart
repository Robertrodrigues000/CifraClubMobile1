import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_versions.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/version/models/version_mock.dart';

class _UserCifraRepository extends Mock implements UserVersionRepository {}

class _SongbookRepository extends Mock implements SongbookRepository {}

void main() {
  late _UserCifraRepository userCifraRepository;
  late _SongbookRepository songbookRepository;

  setUp(() {
    userCifraRepository = _UserCifraRepository();
    songbookRepository = _SongbookRepository();
  });

  test("When call use case and request is successful should remove songs of local db", () async {
    final songs = [getFakeVersion()];
    when(() => songbookRepository.deleteVersions(songbookId: 1, versionsId: [songs.first.remoteDatabaseID!]))
        .thenAnswer((_) => SynchronousFuture(const Ok(null)));
    when(() => userCifraRepository.deleteVersionsById([songs.first.localDatabaseID!]))
        .thenAnswer((invocation) => SynchronousFuture(1));

    final result = await DeleteVersions(songbookRepository, userCifraRepository)(songbookId: 1, versions: songs);

    expect(result.isSuccess, isTrue);

    verify(() => userCifraRepository.deleteVersionsById([songs.first.localDatabaseID!])).called(1);
  });

  test("When call use case and request fails should return request error", () async {
    final songs = [getFakeVersion()];
    when(() => songbookRepository.deleteVersions(versionsId: [songs.first.remoteDatabaseID!], songbookId: 1))
        .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    final result = await DeleteVersions(songbookRepository, userCifraRepository)(songbookId: 1, versions: songs);

    expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "status code", 404));

    verifyNever(() => userCifraRepository.deleteVersionsById(any()));
  });
}
