import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:equatable/equatable.dart';

class Song extends Equatable {
  final Artist? artist;
  final int id;
  final String name;
  final String url;
  final bool isVerified;

  const Song({
    this.artist,
    required this.id,
    required this.name,
    required this.url,
    required this.isVerified,
  });

  @override
  List<Object?> get props => [id, name, url];
}
