// coverage:ignore-file
abstract class HomeState {}

class HomeInitialState implements HomeState {}

class HomeLoadedState implements HomeState {
  final String selectedGenre;
  final List<int> highlights;
  final List<int> topCifras;
  final List<int> topArtists;
  final List<int> videoLessons;
  final List<int> blog;
  final List<String> genres;

  HomeLoadedState({
    required this.highlights,
    required this.topCifras,
    required this.topArtists,
    required this.videoLessons,
    required this.blog,
    required this.selectedGenre,
    required this.genres,
  });
}

class HomeLoadingState implements HomeState {}

class HomeErrorState implements HomeState {}
