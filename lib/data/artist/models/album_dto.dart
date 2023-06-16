import 'package:cifraclub/data/artist/models/album_image_dto.dart';
import 'package:cifraclub/domain/artist/models/album.dart';
import 'package:json_annotation/json_annotation.dart';

part 'album_dto.g.dart';

@JsonSerializable(createToJson: false)
class AlbumDto {
  final String artistName;
  final int id;
  @JsonKey(name: "dns")
  final String artistUrl;
  final AlbumImageDto? image;
  final String? recordCompany;
  final int? releaseYear;
  final String title;
  final int? totalSongs;
  @JsonKey(name: "url")
  final String albumUrl;
  final int? totalSongsRelated;

  const AlbumDto(
      {required this.artistName,
      required this.id,
      required this.artistUrl,
      this.image,
      this.recordCompany,
      this.releaseYear,
      required this.title,
      this.totalSongs,
      required this.albumUrl,
      this.totalSongsRelated});

  factory AlbumDto.fromJson(Map<String, dynamic> json) => _$AlbumDtoFromJson(json);

  Album toDomain() => Album(
        artistName: artistName,
        id: id,
        artistUrl: artistUrl,
        image: image?.toDomain(),
        recordCompany: recordCompany,
        releaseYear: releaseYear != 0 ? releaseYear : null,
        title: title,
        albumUrl: albumUrl,
        totalSongs: totalSongs,
        totalSongsRelated: totalSongsRelated,
      );
}
