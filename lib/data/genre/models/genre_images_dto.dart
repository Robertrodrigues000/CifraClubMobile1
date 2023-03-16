import 'package:cifraclub/domain/genre/models/genre_images.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genre_images_dto.g.dart';

@JsonSerializable(createToJson: false)
class GenreImagesDto {
  final String? light;
  final String? lightInactive;
  final String? dark;
  final String? darkInactive;

  GenreImagesDto({required this.light, required this.lightInactive, required this.dark, required this.darkInactive});

  factory GenreImagesDto.fromJson(Map<String, dynamic> json) => _$GenreImagesDtoFromJson(json);

  GenreImages toDomain() {
    return GenreImages(light: light, lightInactive: lightInactive, dark: dark, darkInactive: darkInactive);
  }
}
