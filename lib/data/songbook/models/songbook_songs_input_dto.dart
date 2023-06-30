import 'package:cifraclub/data/songbook/models/songbook_song_input_dto.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:json_annotation/json_annotation.dart';

part 'songbook_songs_input_dto.g.dart';

@JsonSerializable(createFactory: false)
class SongbookSongsInputDto {
  final List<SongbookSongInputDto> songs;

  SongbookSongsInputDto({
    required this.songs,
  });

  SongbookSongsInputDto.fromDomain(List<Version> songs)
      : this(songs: songs.map(SongbookSongInputDto.fromDomain).toList());

  Map<String, dynamic> toJson() => _$SongbookSongsInputDtoToJson(this);
}
