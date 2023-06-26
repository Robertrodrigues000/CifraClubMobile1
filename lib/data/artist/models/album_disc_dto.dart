import 'package:cifraclub/data/artist/models/album_disc_song_dto.dart';
import 'package:cifraclub/domain/artist/models/album_disc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'album_disc_dto.g.dart';

@JsonSerializable(createToJson: false)
class AlbumDiscDto {
  @JsonKey(name: "songs")
  final List<AlbumDiscSongDto> songs;

  AlbumDiscDto({required this.songs});

  factory AlbumDiscDto.fromJson(Map<String, dynamic> json) => _$AlbumDiscDtoFromJson(json);
  // coverage:ignore-start
  AlbumDisc toDomain() => AlbumDisc(
        songs: songs.map((song) => song.toDomain()).toList(),
      );
  // coverage:ignore-end
}
