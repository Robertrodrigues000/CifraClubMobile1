import 'package:cifraclub/domain/artist/models/album_disc.dart';
import 'package:cifraclub/domain/artist/models/album_image.dart';
import 'package:equatable/equatable.dart';

class AlbumDetail extends Equatable {
  final String artistName;
  final List<AlbumDisc> discs;
  final int id;
  final String artistUrl;
  final String albumUrl;
  final AlbumImage? image;
  final String? recordCompany;
  final int? releaseYear;
  final String title;
  final int? totalSongs;
  final int? totalSongsRelated;

  const AlbumDetail({
    required this.artistName,
    required this.discs,
    required this.id,
    required this.artistUrl,
    required this.albumUrl,
    this.image,
    this.recordCompany,
    this.releaseYear,
    required this.title,
    this.totalSongs,
    this.totalSongsRelated,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [artistName, discs, artistUrl, id, albumUrl];
  // coverage:ignore-end
}
