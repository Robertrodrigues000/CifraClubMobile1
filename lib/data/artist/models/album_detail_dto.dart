import 'package:cifraclub/data/artist/models/album_image_dto.dart';
import 'package:cifraclub/data/artist/models/album_disc_dto.dart';
import 'package:cifraclub/domain/artist/models/album_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'album_detail_dto.g.dart';

@JsonSerializable(createToJson: false)
class AlbumDetailDto {
  final String artistName;
  @JsonKey(name: "discs")
  final List<AlbumDiscDto> discs;
  final int id;
  @JsonKey(name: "dns")
  final String artistUrl;
  @JsonKey(name: "url")
  final String albumUrl;
  final AlbumImageDto? image;
  final String? recordCompany;
  final int? releaseYear;
  final String title;
  final int? totalSongs;
  final int? totalSongsRelated;

  AlbumDetailDto({
    required this.artistName,
    required this.discs,
    required this.id,
    required this.artistUrl,
    required this.albumUrl,
    this.image,
    this.recordCompany,
    this.releaseYear,
    required this.title,
    this.totalSongs,
    this.totalSongsRelated,
  });

  factory AlbumDetailDto.fromJson(Map<String, dynamic> json) => _$AlbumDetailDtoFromJson(json);

  AlbumDetail toDomain() => AlbumDetail(
        artistName: artistName,
        discs: discs.map((albumDisc) => albumDisc.toDomain()).toList(),
        id: id,
        artistUrl: artistUrl,
        albumUrl: albumUrl,
        image: image?.toDomain(),
        recordCompany: recordCompany,
        releaseYear: releaseYear,
        title: title,
        totalSongs: totalSongs,
        totalSongsRelated: totalSongsRelated,
      );
}
