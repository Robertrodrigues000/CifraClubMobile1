import 'package:cifraclub/domain/home/models/highlight.dart';
import 'package:cifraclub/domain/home/models/home_image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_lessons_image_dto.g.dart';

@JsonSerializable(createToJson: false)
class VideoLessonsImageDto {
  @JsonKey(name: "img")
  final String image;
  @JsonKey(name: "imgmq")
  final String imagemq;
  @JsonKey(name: "imgsd")
  final String imagesd;

  HomeImage toDomain() => HomeImage(small: imagesd, medium: imagemq, large: image);

  factory VideoLessonsImageDto.fromJson(Map<String, dynamic> json) => _$VideoLessonsImageDtoFromJson(json);

  VideoLessonsImageDto({
    required this.image,
    required this.imagemq,
    required this.imagesd,
  });
}
