import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart';
import 'package:cifraclub/presentation/screens/genre/genre_state.dart';

class GenreBloc extends Cubit<GenreState> {
  final GetTopArtists _getTopArtists;
  final String _genreUrl;

  GenreBloc(
    this._genreUrl,
    String? genreName,
    this._getTopArtists,
  ) : super(GenreLoadingState(genreName: genreName));

  Future<void> requestTopArtists() async {
    var topArtistsResult = await _getTopArtists(
      genreUrl: _genreUrl,
    );
    topArtistsResult.when(
      success: (list) {
        if (list.items.isEmpty) {
          emit(GenreErrorState(genreName: state.genreName, error: ServerError()));
        } else {
          emit(GenreLoadedState(
            artists: list.items,
            genreName: state.genreName ?? list.items.first.genre?.name,
          ));
        }
      },
      failure: (error) => emit(GenreErrorState(genreName: state.genreName, error: error)),
    );
  }
}
