import 'package:copy_with_extension/copy_with_extension.dart';

part 'artist_state.g.dart';

@CopyWith()
class ArtistState {
  final List<int> songs;
  final List<int> albuns;
  const ArtistState({
    this.songs = const [],
    this.albuns = const [],
  });
}
