import 'package:cifraclub/data/cifra/data_source/user_cifra_data_source.dart';
import 'package:cifraclub/data/cifra/models/user_cifra_dto.dart';
import 'package:cifraclub/data/cifra/repository/user_cifra_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

import '../../../shared_mocks/domain/cifra/models/cifra_mock.dart';

class _UserCifraDataSourceMock extends Mock implements UserCifraDataSource {}

class _UserCifraDtoMock extends Mock implements UserCifraDto {}

void main() {
  test("When `clearAllCifras` is called should clear user cifras", () async {
    final userCifraDataSource = _UserCifraDataSourceMock();
    when(userCifraDataSource.clearAllCifras).thenAnswer((_) => SynchronousFuture(null));

    final userCifraRepository = UserCifraRepositoryImpl(userCifraDataSource);

    await userCifraRepository.clearAllCifras();

    verify(userCifraDataSource.clearAllCifras).called(1);
  });

  test("When `getTotalSongbookCifras` is called should return stream of count cifras in a songbook", () async {
    final userCifraDataSource = _UserCifraDataSourceMock();
    when(() => userCifraDataSource.getTotalSongbookCifras(1)).thenAnswer((_) => BehaviorSubject.seeded(10));

    final userCifraRepository = UserCifraRepositoryImpl(userCifraDataSource);

    final countCifrasStream = userCifraRepository.getTotalSongbookCifras(1);

    verify(() => userCifraDataSource.getTotalSongbookCifras(1)).called(1);
    expect(countCifrasStream, emitsInOrder([10]));
  });

  test("When `getUserCifrasFromSongbook` is called should return list of cifras", () async {
    final userCifraDto = _UserCifraDtoMock();
    final fakeCifra = getFakeCifra();
    when(userCifraDto.toDomain).thenReturn(fakeCifra);

    final userCifraDataSource = _UserCifraDataSourceMock();
    when(() => userCifraDataSource.getCifrasFromSongbook(1)).thenAnswer((_) => SynchronousFuture([userCifraDto]));

    final userCifraRepository = UserCifraRepositoryImpl(userCifraDataSource);

    final cifras = await userCifraRepository.getUserCifrasFromSongbook(1);

    verify(() => userCifraDataSource.getCifrasFromSongbook(1)).called(1);
    verify(userCifraDto.toDomain).called(1);
    expect(cifras, isNotNull);
    expect(cifras, [fakeCifra]);
  });

  test("When `addCifrasToSongbook` is called should return ids of cifras deleted", () async {
    final cifras = [getFakeCifra(), getFakeCifra()];
    final cifrasIds = cifras.map((e) => e.localDatabaseID!).toList();

    final userCifraDataSource = _UserCifraDataSourceMock();
    when(() => userCifraDataSource.addCifrasToSongbook(any())).thenAnswer((_) => SynchronousFuture(cifrasIds));

    final userCifraRepository = UserCifraRepositoryImpl(userCifraDataSource);

    final deletedIds = await userCifraRepository.addCifrasToSongbook(cifras, 1);
    final domainCifras = cifras.map((e) => UserCifraDto.fromDomain(e, 1)).toList();

    verify(() => userCifraDataSource.addCifrasToSongbook(domainCifras)).called(1);
    expect(deletedIds, cifrasIds);
  });

  test("When `getImagesPreview` is called should return list of images", () async {
    final userCifraDataSource = _UserCifraDataSourceMock();
    when(() => userCifraDataSource.getImagesPreview(1)).thenAnswer((_) => SynchronousFuture(["image1", "image2"]));

    final userCifraRepository = UserCifraRepositoryImpl(userCifraDataSource);
    final images = await userCifraRepository.getImagesPreview(1);

    expect(images, ["image1", "image2"]);
    verify(() => userCifraDataSource.getImagesPreview(1)).called(1);
  });

  test("When `deleteCifrasBySongbookId` is called should return quantity of deleted cifras", () async {
    final userCifraDataSource = _UserCifraDataSourceMock();
    when(() => userCifraDataSource.deleteCifras(4)).thenAnswer((_) => SynchronousFuture(2));

    final userCifraRepository = UserCifraRepositoryImpl(userCifraDataSource);
    final countCifrasDeleted = await userCifraRepository.deleteCifrasBySongbookId(4);

    expect(countCifrasDeleted, 2);
    verify(() => userCifraDataSource.deleteCifras(4)).called(1);
  });
}
