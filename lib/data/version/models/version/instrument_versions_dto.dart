import 'package:cifraclub/data/version/models/version/instrument_version_dto.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/instrument_version.dart';
import 'package:json_annotation/json_annotation.dart';

part 'instrument_versions_dto.g.dart';

@JsonSerializable(createToJson: false)
class InstrumentVersionsDto {
  @JsonKey(name: 'songs')
  final List<InstrumentVersionDto>? versions;
  final String label;
  final int type;

  InstrumentVersionsDto({
    required this.versions,
    required this.label,
    required this.type,
  });

  factory InstrumentVersionsDto.fromJson(Map<String, dynamic> json) => _$InstrumentVersionsDtoFromJson(json);

  ({Instrument instrument, List<InstrumentVersion> versions}) toDomain() => (
        instrument: Instrument.getInstrumentByType(type) ?? Instrument.unknown,
        versions: versions?.map((e) => e.toDomain()).toList() ?? []
      );
}
