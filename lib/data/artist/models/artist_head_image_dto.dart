import 'package:cifraclub/domain/artist/models/artist_head_image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist_head_image_dto.g.dart';

@JsonSerializable(createToJson: false)
class ArtistHeadImageDto {
  @JsonKey(name: "original")
  final String? image;
  final int? width;
  final int? height;
  final String? color;

  ArtistHeadImageDto({this.image, this.width, this.height, this.color});

  factory ArtistHeadImageDto.fromJson(Map<String, dynamic> json) => _$ArtistHeadImageDtoFromJson(json);

  ArtistHeadImage toDomain() {
    return ArtistHeadImage(image: image, color: color);
  }
}
