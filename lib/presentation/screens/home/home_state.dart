// coverage:ignore-file
import 'package:cifraclub/domain/user/models/user.dart';

abstract class HomeState {
  User? get user;
  bool isPro = false;

  HomeState copyWith(User? user, [bool? isPro]);
}

class HomeInitialState implements HomeState {
  @override
  User? user;
  @override
  bool isPro;

  HomeInitialState({required this.user, required this.isPro});

  @override
  HomeState copyWith(User? user, [bool? isPro]) => HomeInitialState(user: user, isPro: isPro ?? this.isPro);
}

class HomeLoadedState implements HomeState {
  final String selectedGenre;
  final List<int> highlights;
  final List<int> topCifras;
  final List<int> topArtists;
  final List<int> videoLessons;
  final List<int> blog;
  final List<String> genres;
  @override
  User? user;
  @override
  bool isPro;

  HomeLoadedState(
      {required this.highlights,
      required this.topCifras,
      required this.topArtists,
      required this.videoLessons,
      required this.blog,
      required this.selectedGenre,
      required this.genres,
      required this.user,
      required this.isPro});

  @override
  HomeState copyWith(User? user, [bool? isPro]) => HomeLoadedState(
      highlights: highlights,
      topCifras: topCifras,
      topArtists: topArtists,
      videoLessons: videoLessons,
      blog: blog,
      selectedGenre: selectedGenre,
      genres: genres,
      user: user,
      isPro: isPro ?? this.isPro);
}

class HomeLoadingState implements HomeState {
  @override
  User? user;
  @override
  bool isPro;

  HomeLoadingState({required this.user, required this.isPro});

  @override
  HomeState copyWith(User? user, [bool? isPro]) => HomeLoadingState(user: user, isPro: isPro ?? this.isPro);
}

class HomeErrorState implements HomeState {
  @override
  User? user;
  @override
  bool isPro;

  HomeErrorState({required this.user, required this.isPro});

  @override
  HomeState copyWith(User? user, [bool? isPro]) => HomeErrorState(user: user, isPro: isPro ?? this.isPro);
}
