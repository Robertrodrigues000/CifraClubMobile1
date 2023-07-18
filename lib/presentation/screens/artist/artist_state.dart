import 'package:cifraclub/domain/artist/models/album.dart';
import 'package:cifraclub/domain/artist/models/artist_info.dart';
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'artist_state.g.dart';

@CopyWith()
class ArtistState {
  final List<ArtistSong> songs;
  final List<Album> albums;
  final ArtistInfo? artistInfo;
  final List<Instrument> instruments;
  final Instrument? selectedInstrument;
  final bool isLoading;
  final bool isFavorite;
  final User? user;
  final RequestError? error;

  const ArtistState({
    this.isLoading = false,
    this.isFavorite = false,
    this.error,
    this.selectedInstrument,
    this.instruments = const [],
    this.artistInfo,
    this.user,
    this.songs = const [],
    this.albums = const [],
  });
}
