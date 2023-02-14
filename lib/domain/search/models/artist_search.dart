import 'package:cifraclub/domain/search/models/search.dart';

class ArtistSearch implements Search {
  final int id;
  final String name;
  final String url;
  final String? imageUrl;

  const ArtistSearch({required this.id, required this.name, required this.url, required this.imageUrl});

  // coverage:ignore-start
  @override
  List<Object?> get props => [id, name, url, imageUrl];

  @override
  bool? get stringify => true;
  // coverage:ignore-end
}
