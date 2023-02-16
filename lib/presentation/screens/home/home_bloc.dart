// coverage:ignore-file
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart';
import 'package:cifraclub/presentation/screens/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc(this._getUserGenresAsStream) : super(HomeLoadingState());
  List<int> highlights = List.generate(10, (index) => index + 1);
  List<int> topArtists = List.generate(4, (index) => index + 1);
  List<int> topCifras = List.generate(10, (index) => index + 1);
  List<int> videoLessons = List.generate(4, (index) => index + 1);
  List<int> blogPosts = List.generate(5, (index) => index + 1);
  List<String> genres = [];

  final GetUserGenresAsStream _getUserGenresAsStream;

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

    var stream = _getUserGenresAsStream();
    var firstValueOfStream = await stream.first;
    var genreNames = firstValueOfStream.map((e) => e.name).toList();
    genres = genreNames;

    emit(
      HomeLoadedState(
        highlights: highlights,
        topCifras: topCifras,
        topArtists: topArtists,
        videoLessons: videoLessons,
        blog: blogPosts,
        selectedGenre: genreNames.first,
        genres: genreNames,
      ),
    );
  }
}

// AppBar
// Filtros
// Erro

// AppBar -> usuario + se é Pro ou não
// Filtros -> Lista de filtros + filtro ativo
// Loading
