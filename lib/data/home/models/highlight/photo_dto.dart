import 'package:cifraclub/domain/home/models/images_size.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_dto.g.dart';

@JsonSerializable(createToJson: false)
class PhotoDto extends Equatable {
  @JsonKey(name: "x1")
  final String small;
  @JsonKey(name: "x2")
  final String medium;
  @JsonKey(name: "x3")
  final String? large;

  ImagesSize toDomain() => ImagesSize(small: small, medium: medium, large: large);

  factory PhotoDto.fromJson(Map<String, dynamic> json) => _$PhotoDtoFromJson(json);

  const PhotoDto({required this.small, required this.medium, required this.large});

  @override
  List<Object?> get props => [small, medium, large];
}
