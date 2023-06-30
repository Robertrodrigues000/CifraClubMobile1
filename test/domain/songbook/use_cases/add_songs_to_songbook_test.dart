import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/add_songs_to_songbook.dart';
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

  test("When call use case and request is successful should return songs and add to local db", () async {
    final songs = [getFakeVersion()];
    when(() => userCifraRepository.deleteVersionsBySongbookId(1)).thenAnswer((_) => SynchronousFuture(1));
    when(() => userCifraRepository.addVersionToSongbook(songs, 1))
        .thenAnswer((_) => SynchronousFuture([songs.first.localDatabaseID!]));
    when(() => songbookRepository.addSongsToSongbook(songs: songs, songbookId: 1))
        .thenAnswer((_) => SynchronousFuture(Ok(songs)));

    final result = await AddSongsToSongbook(songbookRepository, userCifraRepository)(songbookId: 1, songs: songs);

    expect(result.get(), songs);

    verify(() => userCifraRepository.deleteVersionsBySongbookId(1)).called(1);
    verify(() => userCifraRepository.addVersionToSongbook(songs, 1)).called(1);
  });

  test("When call use case and request fails should return request error", () async {
    final songs = [getFakeVersion()];
    when(() => songbookRepository.addSongsToSongbook(songs: songs, songbookId: 1))
        .thenAnswer((_) => SynchronousFuture(Err(ServerError(statusCode: 404))));

    final result = await AddSongsToSongbook(songbookRepository, userCifraRepository)(songbookId: 1, songs: songs);

    expect(result.getError(), isA<ServerError>().having((error) => error.statusCode, "status code", 404));

    verifyNever(() => userCifraRepository.deleteVersionsBySongbookId(any()));
    verifyNever(() => userCifraRepository.addVersionToSongbook(any(), any()));
  });
}
