// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:cifraclub/domain/genre/entities/genre.dart';

part 'genre_dto.g.dart';

@JsonSerializable(createToJson: false)
class GenreDto extends Equatable {
  final String name;
  final String url;

  const GenreDto({
    required this.name,
    required this.url,
  });

  factory GenreDto.fromJson(Map<String, dynamic> json) => _$GenreDtoFromJson(json);

  Genre toDomain() {
    return Genre(name: name, url: url);
  }

  @override
  List<Object> get props => [name, url];
}
