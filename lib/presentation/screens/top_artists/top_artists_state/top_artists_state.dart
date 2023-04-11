// coverage:ignore-file
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'top_artists_state.g.dart';

@CopyWith()
class TopArtistsState {
  final String? selectedGenre;
  final List<Genre> genres;
  final List<Artist> topArtists;
  final RequestError? error;
  final bool isLoadingArtists;

  TopArtistsState({
    this.selectedGenre,
    this.genres = const [],
    this.topArtists = const [],
    this.error,
    this.isLoadingArtists = false,
  });
}
