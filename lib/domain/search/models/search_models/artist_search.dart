import 'package:cifraclub/domain/search/models/search_models/search.dart';
import 'package:equatable/equatable.dart';

class ArtistSearch extends Equatable implements Search {
  final int id;
  final String name;
  final String url;
  final String? imageUrl;

  const ArtistSearch({required this.id, required this.name, required this.url, required this.imageUrl});

  // coverage:ignore-start
  @override
  List<Object?> get props => [id, name, url, imageUrl];
  // coverage:ignore-end
}
