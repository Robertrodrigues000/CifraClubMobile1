import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_recents.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _UserVersionRepositoryMock extends Mock implements UserVersionRepository {}

class _SongbookRepositoryMock extends Mock implements SongbookRepository {}

class _UserSongbookRepositoryMock extends Mock implements UserSongbookRepository {}

void main() {
  late _UserVersionRepositoryMock userVersionRepository;
  late _SongbookRepositoryMock songbookRepository;
  late _UserSongbookRepositoryMock userSongbookRepository;

  setUp(() {
    userVersionRepository = _UserVersionRepositoryMock();
    songbookRepository = _SongbookRepositoryMock();
    userSongbookRepository = _UserSongbookRepositoryMock();
  });

  test("When clearRecents is called should delete all songs from recents list", () async {
    when(songbookRepository.clearRecents).thenAnswer((_) => SynchronousFuture(const Ok(null)));
    when(() => userVersionRepository.deleteVersionsBySongbookId(any())).thenAnswer((_) => SynchronousFuture(1));
    when(() => userSongbookRepository.updateTotalSongs(songbookId: any(named: "songbookId")))
        .thenAnswer((_) => SynchronousFuture(1));

    final clearRecents = ClearRecents(userVersionRepository, songbookRepository, userSongbookRepository);
    clearRecents();

    await Future.delayed(Duration.zero);

    verify(songbookRepository.clearRecents).called(1);
    verify(() => userVersionRepository.deleteVersionsBySongbookId(any())).called(1);
    verify(() => userSongbookRepository.updateTotalSongs(songbookId: any(named: "songbookId"))).called(1);
  });
}
