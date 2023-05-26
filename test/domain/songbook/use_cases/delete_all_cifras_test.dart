import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_all_cifras.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _UserSongbookRepository extends Mock implements UserSongbookRepository {}

class _SongbookRepository extends Mock implements SongbookRepository {}

void main() {
  late _UserSongbookRepository userSongbookRepository;
  late _SongbookRepository songbookRepository;

  setUp(() {
    userSongbookRepository = _UserSongbookRepository();
    songbookRepository = _SongbookRepository();
  });

  test("When have cifras and return sucess in api should return sucessful", () async {
    when(() => userSongbookRepository.deleteCifras(100)).thenAnswer((_) => SynchronousFuture(1));
    when(() => userSongbookRepository.getCifrasIds(100)).thenAnswer((_) => SynchronousFuture([1]));
    when(() => songbookRepository.deleteCifras(
          songbookId: 100,
          cifrasIds: any(named: "cifrasIds"),
        )).thenAnswer((_) => SynchronousFuture(const Ok(null)));

    final result = await DeleteAllCifras(songbookRepository, userSongbookRepository)(100);

    expect(result.isSuccess, isTrue);
  });
}
