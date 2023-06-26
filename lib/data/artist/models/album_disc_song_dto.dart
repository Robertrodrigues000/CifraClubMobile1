import 'package:cifraclub/data/artist/models/artist_song_dto.dart';
import 'package:cifraclub/domain/artist/models/album_disc_song.dart';
import 'package:json_annotation/json_annotation.dart';
part 'album_disc_song_dto.g.dart';

@JsonSerializable(createToJson: false)
class AlbumDiscSongDto {
  @JsonKey(name: "disk")
  final int disc;
  final int id;
  final String name;
  final int order;
  @JsonKey(name: "song")
  final ArtistSongDto? artistSong;

  AlbumDiscSongDto({
    required this.disc,
    required this.id,
    required this.name,
    required this.order,
    this.artistSong,
  });

  factory AlbumDiscSongDto.fromJson(Map<String, dynamic> json) => _$AlbumDiscSongDtoFromJson(json);

  AlbumDiscSong toDomain() => AlbumDiscSong(
        disc: disc,
        id: id,
        name: name,
        order: order,
        artistSong: artistSong?.toDomain(),
      );
}
