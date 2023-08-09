import 'package:cifraclub/domain/version/models/chord.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chord_dto.g.dart';

@JsonSerializable(createToJson: false)
class ChordDto {
  final String chord;
  final String alt;
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
    required this.chord,
    required this.alt,
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
        chord: chord,
        alt: alt,
        guitar: guitar,
        cavaco: cavaco,
        keyboard: keyboard,
        ukulele: ukulele,
        viola: viola,
        violaMi: violaMi,
        violaRa: violaRa,
      );
}
