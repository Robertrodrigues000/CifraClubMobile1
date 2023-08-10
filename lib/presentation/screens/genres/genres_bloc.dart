import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/genres/genres_state.dart';
import 'package:cifraclub/presentation/screens/genres/models/genre_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class GenresBloc extends Cubit<GenresState> {
  final GetGenres _getGenres;

  GenresBloc(this._getGenres) : super(GenresLoadingState());

  Future<void> init() async {
    await requestGenres();
  }

  Future<void> requestGenres() async {
    var genresResult = await _getGenres();

    genresResult.when(
      success: (allGenres) {
        if (allGenres.all.isEmpty || allGenres.top.isEmpty) {
          emit(GenresErrorState(ServerError()));
        } else {
          List<GenreItem> genreItemList = [
            const GenreHeaderItem(type: GenreHeaderType.top),
            ...allGenres.top
                .map(
                  (genre) => GenreListItem(genre: genre),
                )
                .toList(),
            GenreDivider(),
            const GenreHeaderItem(type: GenreHeaderType.all),
            ...allGenres.all
                .map(
                  (genre) => GenreListItem(genre: genre),
                )
                .toList(),
          ];

          emit(GenresLoadedState(genres: genreItemList));
        }
      },
      failure: (error) => emit(GenresErrorState(error)),
    );
  }
}
