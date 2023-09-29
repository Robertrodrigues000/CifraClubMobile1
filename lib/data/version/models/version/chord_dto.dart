import 'package:cifraclub/domain/version/models/chord.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chord_dto.g.dart';

@JsonSerializable(createToJson: false)
class ChordDto {
  @JsonKey(name: "chord")
  final String name;
  @JsonKey(name: "alt")
  final String shapeName;
  final List<String>? guitar;
  final List<String>? cavaco;
  final List<String>? keyboard;
  final List<String>? ukulele;
  final List<String>? viola;
  @JsonKey(name: "viola_mi")
  final List<String>? violaMi;
  @JsonKey(name: "viola_ra")
  final List<String>? violaRa;

  ChordDto({
    required this.name,
    required this.shapeName,
    this.guitar,
    this.cavaco,
    this.keyboard,
    this.ukulele,
    this.viola,
    this.violaMi,
    this.violaRa,
  });

  factory ChordDto.fromJson(Map<String, dynamic> json) => _$ChordDtoFromJson(json);

  Chord toDomain() => Chord(
        name: name,
        shapeName: shapeName,
        guitar: guitar,
        cavaco: cavaco,
        keyboard: keyboard,
        ukulele: ukulele,
        viola: viola,
        violaMi: violaMi,
        violaRa: violaRa,
      );
}
