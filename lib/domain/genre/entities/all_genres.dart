// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:cifraclub/domain/genre/entities/genre.dart';

class AllGenres extends Equatable {
  final List<Genre> top;
  final List<Genre> all;

  const AllGenres({
    required this.top,
    required this.all,
  });

  @override
  List<Object> get props => [top, all];
}
