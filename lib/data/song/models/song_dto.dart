import 'package:cifraclub/data/artist/models/artist_dto.dart';
import 'package:cifraclub/domain/song/models/song.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'song_dto.g.dart';

@JsonSerializable(createToJson: false)
class SongDto extends Equatable {
  final ArtistDto? artist;
  final int id;
  final String name;
  final String url;

  @JsonKey(name: "verified")
  final bool? isVerified;

  const SongDto({
    this.artist,
    required this.id,
    required this.name,
    required this.url,
    required this.isVerified,
  });

  Song toDomain() {
    return Song(
      artist: artist?.toDomain(),
      id: id,
      name: name,
      url: url,
      isVerified: isVerified ?? false,
    );
  }

  factory SongDto.fromJson(Map<String, dynamic> json) => _$SongDtoFromJson(json);

  @override
  List<Object?> get props => [id, name, url];
}
