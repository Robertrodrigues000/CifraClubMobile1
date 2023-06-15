import 'package:cifraclub/domain/cifra/repository/user_cifra_repository.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/cifra/models/cifra_mock.dart';

class _UserCifraRepositoryMock extends Mock implements UserCifraRepository {}

class _UserSongbookRepository extends Mock implements UserSongbookRepository {}

void main() {
  test("When updateSongbookPreview is called should return id of songbook updated", () async {
    final userCifraRepository = _UserCifraRepositoryMock();
    final userSongbookRepository = _UserSongbookRepository();
    final fakeCifra = getFakeCifra();
    when(() => userCifraRepository.getImagesPreview(10))
        .thenAnswer((_) => SynchronousFuture([fakeCifra.artist.image?.size162]));
    when(() => userSongbookRepository.updateSongbookPreview(any(), any())).thenAnswer((_) => SynchronousFuture(10));

    final result = await UpdateSongbookPreview(userCifraRepository, userSongbookRepository)(10);

    expect(result, 10);
    verify(() => userCifraRepository.getImagesPreview(10)).called(1);
    verify(() => userSongbookRepository.updateSongbookPreview(10, [fakeCifra.artist.image?.size162])).called(1);
  });
}
