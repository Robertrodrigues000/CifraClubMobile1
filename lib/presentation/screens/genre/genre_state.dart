import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/shared/request_error.dart';

abstract class GenreState {
  String? get genreName;
}

class GenreLoadingState implements GenreState {
  @override
  final String? genreName;

  const GenreLoadingState({required this.genreName});
}

class GenreErrorState implements GenreState {
  @override
  final String? genreName;
  final RequestError error;

  const GenreErrorState({required this.genreName, required this.error});
}

class GenreLoadedState implements GenreState {
  @override
  final String? genreName;
  final List<Artist> artists;

  const GenreLoadedState({required this.genreName, required this.artists});
}
