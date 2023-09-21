import 'package:cifraclub/domain/search/models/search_models/search_item.dart';
import 'package:equatable/equatable.dart';

class AlbumSearch extends Equatable implements SearchItem {
  final String albumName;
  final String albumUrl;
  final int artistId;
  final String artistName;
  final String artistUrl;
  final String? albumCover;
  final String releaseYear;

  const AlbumSearch({
    required this.albumName,
    required this.albumUrl,
    required this.artistId,
    required this.artistName,
    required this.artistUrl,
    required this.albumCover,
    required this.releaseYear,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [albumName, albumUrl, artistId, artistName, artistUrl, albumCover];
// coverage:ignore-end
}
