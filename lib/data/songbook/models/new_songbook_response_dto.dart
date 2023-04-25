import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_songbook_response_dto.g.dart';

/// This class was necessary due to
/// `public` being a integer instead of a boolean
@JsonSerializable(createToJson: false)
class NewSongbookResponseDto {
  final int id;
  final String name;
  @JsonKey(name: "public")
  final int isPublic;

  NewSongbookResponseDto({
    required this.id,
    required this.name,
    this.isPublic = 1,
  });

  factory NewSongbookResponseDto.fromJson(Map<String, dynamic> json) => _$NewSongbookResponseDtoFromJson(json);

  Songbook toDomain() {
    return Songbook(
      id: id,
      name: name,
      isPublic: isPublic == 1,
      type: ListType.user,
      totalSongs: 0,
      createdAt: DateTime.now(),
    );
  }
}
