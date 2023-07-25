import 'package:cifraclub/data/version/models/version_data_song_dto.dart';
import 'package:cifraclub/domain/version/models/version_data_songs_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'version_data_songs_detail_dto.g.dart';

@JsonSerializable(createToJson: false)
class VersionDataSongsDetailDto {
  final List<VersionDataSongDto>? songs;
  final String label;
  final int type;

  VersionDataSongsDetailDto({
    required this.songs,
    required this.label,
    required this.type,
  });

  factory VersionDataSongsDetailDto.fromJson(Map<String, dynamic> json) => _$VersionDataSongsDetailDtoFromJson(json);

  VersionDataSongsDetail toDomain() => VersionDataSongsDetail(
        songs: songs?.map((e) => e.toDomain()).toList(),
        label: label,
        type: type,
      );
}
