import 'package:cifraclub/data/version/models/user_version/user_instrument_versions_dto.dart';
import 'package:cifraclub/domain/version/models/instrument_versions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("When call 'fromDomain'", () {
    final versionDataSongsDetail = InstrumentVersions(
      label: "Bohemian Rhapsody",
      type: 1,
    );

    final userVersionDataSongsDetailDto = UserInstrumentVersionsDto.fromDomain(versionDataSongsDetail);

    expect(userVersionDataSongsDetailDto.label, "Bohemian Rhapsody");
    expect(userVersionDataSongsDetailDto.type, 1);
  });
}
