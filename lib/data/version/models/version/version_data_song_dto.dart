import 'package:cifraclub/domain/version/models/version_data_song.dart';
import 'package:json_annotation/json_annotation.dart';

part 'version_data_song_dto.g.dart';

@JsonSerializable(createToJson: false)
class VersionDataSongDto {
  @JsonKey(name: 'id')
  final int songId;
  final int lyricsId;
  final String name;
  final String url;
  final String description;

  VersionDataSongDto({
    required this.songId,
    required this.lyricsId,
    required this.name,
    required this.url,
    required this.description,
  });

  factory VersionDataSongDto.fromJson(Map<String, dynamic> json) => _$VersionDataSongDtoFromJson(json);

  VersionDataSong toDomain() =>
      VersionDataSong(songId: songId, lyricsId: lyricsId, name: name, url: url, description: description);
}
