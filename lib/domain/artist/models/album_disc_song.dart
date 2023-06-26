import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:equatable/equatable.dart';

class AlbumDiscSong extends Equatable {
  final int disc;
  final int id;
  final String name;
  final int order;
  final ArtistSong? artistSong;

  const AlbumDiscSong({
    required this.disc,
    required this.id,
    required this.name,
    required this.order,
    this.artistSong,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [disc, id, name, order, artistSong];
  // coverage:ignore-end
}
