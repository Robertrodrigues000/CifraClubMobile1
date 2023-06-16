import 'package:cifraclub/data/artist/models/album_dto.dart';
import 'package:cifraclub/domain/artist/models/album.dart';
import 'package:json_annotation/json_annotation.dart';
part 'albums_dto.g.dart';

@JsonSerializable(createToJson: false)
class AlbumsDto {
  final List<AlbumDto> albums;

  const AlbumsDto({required this.albums});

  factory AlbumsDto.fromJson(Map<String, dynamic> json) => _$AlbumsDtoFromJson(json);
  List<Album> toDomain() => albums.map((e) => e.toDomain()).toList();
}
