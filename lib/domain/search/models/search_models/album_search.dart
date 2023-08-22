import 'package:cifraclub/domain/search/models/search_models/search.dart';
import 'package:equatable/equatable.dart';

class AlbumSearch extends Equatable implements Search {
  final String albumName;
  final String albumUrl;
  final int artistId;
  final String artistName;
  final String artistUrl;
  final String? albumCover;

  const AlbumSearch({
    required this.albumName,
    required this.albumUrl,
    required this.artistId,
    required this.artistName,
    required this.artistUrl,
    required this.albumCover,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [albumName, albumUrl, artistId, artistName, artistUrl, albumCover];
// coverage:ignore-end
}
