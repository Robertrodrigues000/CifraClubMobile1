import 'package:cifraclub/domain/search/models/search.dart';
import 'package:equatable/equatable.dart';

class SongSearch extends Equatable implements Search {
  final int songId;
  final String songName;
  final String songUrl;
  final int artistId;
  final String artistName;
  final String artistUrl;
  final String? artistImage;

  const SongSearch({
    required this.songId,
    required this.songName,
    required this.songUrl,
    required this.artistId,
    required this.artistName,
    required this.artistUrl,
    required this.artistImage,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [songId, songName, songUrl, artistId, artistName, artistUrl, artistImage];
  // coverage:ignore-end
}
