// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cifraclub/data/artist/models/artist_dto.dart';

part 'top_artists_dto.g.dart';

@JsonSerializable(createToJson: false)
class TopArtistsDto extends Equatable {
  final bool moreResults;
  final List<ArtistDto> artists;

  const TopArtistsDto({
    required this.moreResults,
    required this.artists,
  });

  PaginatedList<Artist> toDomain() {
    return PaginatedList(items: artists.map((e) => e.toDomain()).toList(growable: false), hasMoreResults: moreResults);
  }

  factory TopArtistsDto.fromJson(Map<String, dynamic> json) => _$TopArtistsDtoFromJson(json);

  // coverage:ignore-start
  @override
  List<Object> get props => [moreResults, artists];
  // coverage:ignore-end
}
