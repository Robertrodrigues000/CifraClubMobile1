import 'package:cifraclub/data/version/models/version/instrument_version_dto.dart';
import 'package:cifraclub/data/version/models/version/instrument_versions_dto.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/version/models/instrument_version_mock.dart';

class InstrumentVersionDtoMock extends Mock implements InstrumentVersionDto {}

void main() {
  test("When `toDomain` is called should convert correctly", () {
    final instrumentVersionDtoMock = InstrumentVersionDtoMock();
    final instrumentVersionsDto = InstrumentVersionsDto(
      versions: [instrumentVersionDtoMock],
      label: "label",
      type: 1,
    );

    when(instrumentVersionDtoMock.toDomain).thenReturn(getFakeInstrumentVersion());
    final instrumentVersions = instrumentVersionsDto.toDomain();

    verify(instrumentVersionDtoMock.toDomain).called(1);
    expect(instrumentVersions.instrument, Instrument.guitar);
  });
}
