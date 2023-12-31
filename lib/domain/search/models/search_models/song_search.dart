import 'package:cifraclub/domain/search/models/search_models/search_item.dart';
import 'package:equatable/equatable.dart';

class SongSearch extends Equatable implements SearchItem {
  final int songId;
  final String songName;
  final String songUrl;
  final int artistId;
  final String artistName;
  final String artistUrl;
  final String? artistImage;
  final bool isVerified;

  const SongSearch({
    required this.songId,
    required this.songName,
    required this.songUrl,
    required this.artistId,
    required this.artistName,
    required this.artistUrl,
    required this.artistImage,
    required this.isVerified,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [songId, songName, songUrl, artistId, artistName, artistUrl, artistImage];
  // coverage:ignore-end
}
