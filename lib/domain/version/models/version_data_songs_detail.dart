import 'package:cifraclub/domain/version/models/version_data_song.dart';

class VersionDataSongsDetail {
  final List<VersionDataSong>? songs;
  final String label;
  final int type;

  VersionDataSongsDetail({
    this.songs,
    required this.label,
    required this.type,
  });
}
