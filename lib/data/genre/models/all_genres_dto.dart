// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cifraclub/data/genre/models/genre_dto.dart';
import 'package:cifraclub/domain/genre/entities/all_genres.dart';

part 'all_genres_dto.g.dart';

@JsonSerializable(createToJson: false)
class AllGenresDto extends Equatable {
  final List<GenreDto> top;
  final List<GenreDto> all;

  const AllGenresDto({
    required this.top,
    required this.all,
  });

  factory AllGenresDto.fromJson(Map<String, dynamic> json) => _$AllGenresDtoFromJson(json);

  AllGenres toDomain() {
    return AllGenres(
      top: top.map((e) => e.toDomain()).toList(),
      all: all.map((e) => e.toDomain()).toList(),
    );
  }

  @override
  List<Object> get props => [top, all];
}
