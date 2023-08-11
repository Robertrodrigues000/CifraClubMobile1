import 'package:cifraclub/data/version/models/user_version/user_instrument_version_dto.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/instrument_version.dart';
import 'package:isar/isar.dart';

part 'user_instrument_versions_dto.g.dart';

@embedded
class UserInstrumentVersionsDto {
  late final List<UserInstrumentVersionDto>? versions;
  @enumerated
  late final Instrument instrument;

  UserInstrumentVersionsDto();

  UserInstrumentVersionsDto.fromDomain(({Instrument instrument, List<InstrumentVersion> versions}) instrumentVersions) {
    versions = instrumentVersions.versions.map(UserInstrumentVersionDto.fromDomain).toList();
    instrument = instrumentVersions.instrument;
  }
}
