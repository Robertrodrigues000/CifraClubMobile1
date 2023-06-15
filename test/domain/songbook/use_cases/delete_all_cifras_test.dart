import 'package:cifraclub/domain/cifra/repository/user_cifra_repository.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_all_cifras.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/cifra/models/cifra_mock.dart';

class _UserCifraRepository extends Mock implements UserCifraRepository {}

class _SongbookRepository extends Mock implements SongbookRepository {}

class _UpdateSongbookPreview extends Mock implements UpdateSongbookPreview {}

void main() {
  late _UserCifraRepository userCifraRepository;
  late _SongbookRepository songbookRepository;
  late _UpdateSongbookPreview updateSongbookPreview;

  setUp(() {
    userCifraRepository = _UserCifraRepository();
    songbookRepository = _SongbookRepository();
    updateSongbookPreview = _UpdateSongbookPreview();
  });

  test("When have cifras and return sucess in api should return sucessful", () async {
    when(() => userCifraRepository.deleteCifrasBySongbookId(100)).thenAnswer((_) => SynchronousFuture(1));
    when(() => userCifraRepository.getUserCifrasFromSongbook(100))
        .thenAnswer((_) => SynchronousFuture([getFakeCifra()]));
    when(() => songbookRepository.deleteCifras(
          songbookId: 100,
          cifrasIds: any(named: "cifrasIds"),
        )).thenAnswer((_) => SynchronousFuture(const Ok(null)));
    when(() => updateSongbookPreview(100)).thenAnswer((invocation) => SynchronousFuture(100));

    final result = await DeleteAllCifras(songbookRepository, userCifraRepository, updateSongbookPreview)(100);

    expect(result.isSuccess, isTrue);
    verify(() => updateSongbookPreview(100)).called(1);
    verify(() => userCifraRepository.getUserCifrasFromSongbook(100)).called(1);
    verify(() => userCifraRepository.deleteCifrasBySongbookId(100)).called(1);
  });
}
