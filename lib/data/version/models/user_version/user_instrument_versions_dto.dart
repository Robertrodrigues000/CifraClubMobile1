import 'package:cifraclub/data/version/models/user_version/user_instrument_version_dto.dart';
import 'package:cifraclub/domain/version/models/instrument_versions.dart';
import 'package:isar/isar.dart';

part 'user_instrument_versions_dto.g.dart';

@embedded
class UserInstrumentVersionsDto {
  late final List<UserInstrumentVersionDto>? songs;
  late final String label;
  late final int type;

  UserInstrumentVersionsDto();

  UserInstrumentVersionsDto.fromDomain(InstrumentVersions songsDetail) {
    songs = songsDetail.versions?.map(UserInstrumentVersionDto.fromDomain).toList();
    label = songsDetail.label;
    type = songsDetail.type;
  }
}
