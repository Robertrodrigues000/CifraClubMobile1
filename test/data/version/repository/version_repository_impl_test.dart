import 'package:cifraclub/data/version/data_source/version_data_source.dart';
import 'package:cifraclub/data/version/models/version/version_data_dto.dart';
import 'package:cifraclub/data/version/repository/version_repository_impl.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/version/models/version_data_mock.dart';

class _VersionDataSourceMock extends Mock implements VersionDataSource {}

class _VersionDataDtoMock extends Mock implements VersionDataDto {}

void main() {
  test("When call 'getVersionData' and is success should return versionData", () async {
    final dataSource = _VersionDataSourceMock();
    final versionDataDto = _VersionDataDtoMock();
    final versionData = getFakeVersionData();

    final repository = VersionRepositoryImpl(dataSource);

    when(() => dataSource.getVersionData(any(), any())).thenAnswer((_) => SynchronousFuture(Ok(versionDataDto)));
    when(versionDataDto.toDomain).thenReturn(versionData);

    final result = await repository.getVersionData(artistUrl: "", songUrl: "");

    verify(versionDataDto.toDomain).called(1);
    verify(() => dataSource.getVersionData(any(), any())).called(1);

    expect(result.isSuccess, true);
    expect(result.get(), versionData);
  });

  test("When call 'getVersionDataByVersionId' and is success should return versionData", () async {
    final dataSource = _VersionDataSourceMock();
    final versionDataDto = _VersionDataDtoMock();
    final versionData = getFakeVersionData();

    final repository = VersionRepositoryImpl(dataSource);

    when(() => dataSource.getVersionDataByVersionId(any(), any()))
        .thenAnswer((_) => SynchronousFuture(Ok(versionDataDto)));
    when(versionDataDto.toDomain).thenReturn(versionData);

    final result = await repository.getVersionDataByVersionId(apiType: Instrument.bass.apiType, versionId: 123456);

    verify(versionDataDto.toDomain).called(1);
    verify(() => dataSource.getVersionDataByVersionId(123456, Instrument.bass.apiType)).called(1);

    expect(result.isSuccess, true);
    expect(result.get(), versionData);
  });
}
