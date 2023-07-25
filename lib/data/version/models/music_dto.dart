import 'package:cifraclub/domain/version/models/music.dart';
import 'package:json_annotation/json_annotation.dart';

part 'music_dto.g.dart';

@JsonSerializable(createToJson: false)
class MusicDto {
  final int id;
  final int lyricsId;
  final String name;
  final String url;
  final String description;

  MusicDto({
    required this.id,
    required this.lyricsId,
    required this.name,
    required this.url,
    required this.description,
  });

  factory MusicDto.fromJson(Map<String, dynamic> json) => _$MusicDtoFromJson(json);

  Music toDomain() => Music(id: id, lyricsId: lyricsId, name: name, url: url, description: description);
}
