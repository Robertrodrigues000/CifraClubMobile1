import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_version_from_recents.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
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

  setUpAll(() {
    userVersionRepository = _UserVersionRepositoryMock();
    songbookRepository = _SongbookRepositoryMock();
    userSongbookRepository = _UserSongbookRepositoryMock();
    registerFallbackValue(Instrument.guitar);
  });

  test("When deleteVersionFromRecents is called should delete a recent song by its id", () async {
    when(() => songbookRepository.deleteVersionFromRecents(
        songId: any(named: "songId"),
        instrument: any(named: "instrument"))).thenAnswer((_) => SynchronousFuture(const Ok(null)));
    when(() => userVersionRepository.deleteVersionFromRecent(any(), any())).thenAnswer((_) => SynchronousFuture(1));
    when(() => userSongbookRepository.updateTotalSongs(songbookId: any(named: "songbookId")))
        .thenAnswer((_) => SynchronousFuture(1));

    final deleteVersionFromRecents =
        DeleteVersionFromRecents(userVersionRepository, songbookRepository, userSongbookRepository);
    deleteVersionFromRecents(songId: 2323, instrument: Instrument.guitar);

    await Future.delayed(Duration.zero);

    verify(() => songbookRepository.deleteVersionFromRecents(songId: 2323, instrument: Instrument.guitar)).called(1);
    verify(() => userVersionRepository.deleteVersionFromRecent(any(), any())).called(1);
    verify(() => userSongbookRepository.updateTotalSongs(songbookId: any(named: "songbookId"))).called(1);
  });
}
