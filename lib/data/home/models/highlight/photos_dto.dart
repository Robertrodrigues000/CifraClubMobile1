import 'package:cifraclub/data/home/models/highlight/photo_dto.dart';
import 'package:cifraclub/domain/home/models/home_image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photos_dto.g.dart';

@JsonSerializable(createToJson: false)
class PhotosDto {
  final PhotoDto app;

  HomeImage toDomain() => app.toDomain();

  factory PhotosDto.fromJson(Map<String, dynamic> json) => _$PhotosDtoFromJson(json);

  PhotosDto({
    required this.app,
  });
}
