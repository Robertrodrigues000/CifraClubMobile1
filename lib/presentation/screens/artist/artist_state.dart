import 'package:cifraclub/domain/artist/models/artist_info.dart';
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'artist_state.g.dart';

@CopyWith()
class ArtistState {
  final List<ArtistSong> songs;
  final List<int> albuns;
  final ArtistInfo? artistInfo;
  const ArtistState({
    this.artistInfo,
    this.songs = const [],
    this.albuns = const [],
  });
}
