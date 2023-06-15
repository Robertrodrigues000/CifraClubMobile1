import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/artist/models/artist_image.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'songbook_cifra_artist_dto.g.dart';

@JsonSerializable()
class SongbookCifraArtistDto extends Equatable {
  final int id;
  final String name;
  final String url;
  final String image;
  final String color;

  const SongbookCifraArtistDto({
    required this.id,
    required this.name,
    required this.url,
    required this.image,
    required this.color,
  });

  factory SongbookCifraArtistDto.fromJson(Map<String, dynamic> json) => _$SongbookCifraArtistDtoFromJson(json);

  Artist toDomain() => Artist(
        url: url,
        image: ArtistImage(color: color, size162: image, size250: image, size50: image),
        name: name,
        id: id,
      );

  @override
  List<Object?> get props => [id, name, url, image, color]; // coverage:ignore-line
}
