import 'package:cifraclub/domain/artist/models/album_image.dart';
import 'package:json_annotation/json_annotation.dart';
part 'album_image_dto.g.dart';

@JsonSerializable(createToJson: false)
class AlbumImageDto {
  final String? color;
  final int height;
  final int width;
  final String image;
  @JsonKey(name: "imageHQ")
  final String? imageHq;
  final String thumb;

  const AlbumImageDto(
      {this.color, required this.height, required this.width, required this.image, this.imageHq, required this.thumb});

  factory AlbumImageDto.fromJson(Map<String, dynamic> json) => _$AlbumImageDtoFromJson(json);

  AlbumImage toDomain() =>
      AlbumImage(color: color, height: height, width: width, image: image, imageHq: imageHq, thumb: thumb);
}
