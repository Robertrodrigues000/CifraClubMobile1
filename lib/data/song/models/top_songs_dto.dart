// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cifraclub/data/song/models/song_dto.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/song/models/song.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'top_songs_dto.g.dart';

@JsonSerializable(createToJson: false)
class TopSongsDto extends Equatable {
  final bool moreResults;
  final List<SongDto> songs;

  const TopSongsDto({
    required this.moreResults,
    required this.songs,
  });

  PaginatedList<Song> toDomain() {
    return PaginatedList(items: songs.map((song) => song.toDomain()).toList(growable: false), hasMoreResults: moreResults);
  }

  factory TopSongsDto.fromJson(Map<String, dynamic> json) => _$TopSongsDtoFromJson(json);

  // coverage:ignore-start
  @override
  List<Object> get props => [moreResults, songs];
  // coverage:ignore-end
}
