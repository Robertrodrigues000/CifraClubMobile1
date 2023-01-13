import 'package:cifraclub/domain/artist/models/artist_image.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist_image_dto.g.dart';

@JsonSerializable(createToJson: false)
class ArtistImageDto extends Equatable {
  @JsonKey(name: "50")
  final String? size50;
  @JsonKey(name: "162")
  final String? size162;
  @JsonKey(name: "250")
  final String? size250;
  final String? color;

  factory ArtistImageDto.fromJson(Map<String, dynamic> json) => _$ArtistImageDtoFromJson(json);

  const ArtistImageDto({this.size50, this.size162, this.size250, this.color});

  ArtistImage toDomain() {
    return ArtistImage(size50: size50, size162: size162, size250: size250, color: color);
  }

  // coverage:ignore-start
  @override
  List<Object?> get props => [size50, size162, size250, color];
  // coverage:ignore-end
}
