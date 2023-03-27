import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/genres/models/genre_item.dart';
import 'package:cifraclub/presentation/widgets/genres_bottom_sheet/genre_bottom_sheet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class GenreBottomSheetBloc extends Cubit<GenreBottomSheetState> {
  final GetGenres _getGenres;

  GenreBottomSheetBloc(this._getGenres) : super(GenreBottomSheetLoadingState());

  void requestGenres() async {
    final listGenre = await _getGenres();

    listGenre.when(
      success: (allGenres) {
        if (allGenres.all.isEmpty || allGenres.top.isEmpty) {
          emit(GenreBottomSheetErrorState(ServerError()));
        } else {
          List<GenreItem> genreItemList = [
            const GenreHeaderItem(type: GenreHeaderType.musicalStyles),
            ...allGenres.top
                .map(
                  (genre) => GenreListItem(genre: genre),
                )
                .toList(),
            GenreDivider(),
            ...allGenres.all
                .map(
                  (genre) => GenreListItem(genre: genre),
                )
                .toList(),
          ];

          emit(GenreBottomSheetLoadedState(genres: genreItemList));
        }
      },
      failure: (RequestError error) {
        emit(GenreBottomSheetErrorState(error));
      },
    );
  }
}
