import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/shared/request_error.dart';

abstract class GenresState {}

class GenresInitialState implements GenresState {}

class GenresLoadingState implements GenresState {}

class GenresErrorState implements GenresState {
  final RequestError error;

  GenresErrorState(this.error);
}

class GenresLoadedState implements GenresState {
  final List<Genre> genres;

  GenresLoadedState(this.genres);
}
