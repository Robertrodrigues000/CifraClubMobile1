import 'package:cifraclub/data/home/models/highlight/photo_dto.dart';
import 'package:cifraclub/domain/home/models/images_size.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photos_dto.g.dart';

@JsonSerializable(createToJson: false)
class PhotosDto {
  final PhotoDto app;

  ImagesSize toDomain() => app.toDomain();

  factory PhotosDto.fromJson(Map<String, dynamic> json) => _$PhotosDtoFromJson(json);

  PhotosDto({
    required this.app,
  });
}
