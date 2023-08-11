import 'package:cifraclub/data/version/models/user_version/user_instrument_versions_dto.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../shared_mocks/domain/version/models/instrument_version_mock.dart';

void main() {
  test("When call 'fromDomain'", () {
    final instrumentVersions = (instrument: Instrument.bass, versions: [getFakeInstrumentVersion()]);

    final userInstrumentVersionsDto = UserInstrumentVersionsDto.fromDomain(instrumentVersions);

    expect(userInstrumentVersionsDto.instrument, Instrument.bass);
    expect(userInstrumentVersionsDto.versions?.length, 1);
  });
}
