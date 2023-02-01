// coverage:ignore-file
import 'package:cifraclub/presentation/screens/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeLoadingState());
  List<int> highlights = List.generate(10, (index) => index + 1);
  List<int> topArtists = List.generate(4, (index) => index + 1);
  List<int> topCifras = List.generate(10, (index) => index + 1);
  List<int> videoLessons = List.generate(4, (index) => index + 1);
  List<int> blogPosts = List.generate(5, (index) => index + 1);
  List<String> genres = ["Todos", "Rock", "Gospel/Religioso", "Pagode", "Pop"];

  void onGenreSelected(String genre) async {
    emit(
      HomeLoadedState(
        highlights: highlights,
        topCifras: topCifras,
        topArtists: topArtists,
        videoLessons: videoLessons,
        blog: blogPosts,
        selectedGenre: genre,
        genres: genres,
      ),
    );
  }

  Future<void> requestHomeData() async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(
      HomeLoadedState(highlights: highlights, topCifras: topCifras, topArtists: topArtists, videoLessons: videoLessons, blog: blogPosts, selectedGenre: genres.first, genres: genres),
    );
  }
}

// AppBar
// Filtros
// Erro

// AppBar -> usuario + se é Pro ou não
// Filtros -> Lista de filtros + filtro ativo
// Loading
