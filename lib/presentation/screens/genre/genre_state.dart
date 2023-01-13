import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/shared/request_error.dart';

abstract class GenreState {}

class GenreLoadingState implements GenreState {}

class GenreErrorState implements GenreState {
  final RequestError error;

  GenreErrorState(this.error);
}

class GenreLoadedState implements GenreState {
  final List<Artist> artists;
  final String genreName;

  GenreLoadedState({required this.artists, required this.genreName});
}
