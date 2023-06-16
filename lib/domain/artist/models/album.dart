import 'package:cifraclub/domain/artist/models/album_image.dart';
import 'package:equatable/equatable.dart';

class Album extends Equatable {
  final String artistName;
  final int id;
  final String artistUrl;
  final AlbumImage? image;
  final String? recordCompany;
  final int? releaseYear;
  final String title;
  final int? totalSongs;
  final String albumUrl;
  final int? totalSongsRelated;

  const Album({
    required this.artistName,
    required this.id,
    required this.artistUrl,
    this.image,
    this.recordCompany,
    this.releaseYear,
    required this.title,
    this.totalSongs,
    required this.albumUrl,
    this.totalSongsRelated,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props =>
      [artistName, id, artistUrl, albumUrl, title, totalSongs, totalSongsRelated, releaseYear, recordCompany];

  // coverage:ignore-end
}
