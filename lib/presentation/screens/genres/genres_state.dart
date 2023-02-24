import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/genres/models/genre_item.dart';

abstract class GenresState {}

class GenresLoadingState implements GenresState {}

class GenresErrorState implements GenresState {
  final RequestError error;

  GenresErrorState(this.error);
}

class GenresLoadedState implements GenresState {
  final List<GenreItem> genres;
  GenresLoadedState({
    required this.genres,
  });
}
