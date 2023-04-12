import 'package:cifraclub/domain/cifra/models/cifra.dart';
import 'package:json_annotation/json_annotation.dart';

part 'songbook_cifra_dto.g.dart';

@JsonSerializable()
class SongbookCifraDto {
  final int id;
  final String name;
  final String songUrl;
  final String? tone;
  final int type;

  SongbookCifraDto({
    required this.id,
    required this.name,
    required this.songUrl,
    this.tone,
    required this.type,
  });

  factory SongbookCifraDto.fromJson(Map<String, dynamic> json) => _$SongbookCifraDtoFromJson(json);

  Cifra toDomain() {
    return Cifra(name: name, id: id, songUrl: songUrl, tone: tone, type: type);
  }
}
