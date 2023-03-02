// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_state/top_artists_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart';

class TopArtistsBloc extends Cubit<TopArtistsState> {
  final GetTopArtists _getTopArtists;
  final GetGenres _getGenres;
  TopArtistsBloc(
    this._getTopArtists,
    this._getGenres,
  ) : super(TopArtistsState(selectedGenre: "todos"));

  Future<void> onGenreSelected(String genreUrl) async {
    if (state.selectedGenre != genreUrl) {
      emit(state.copyWith(selectedGenre: genreUrl));
      await requestTopArtists(genreUrl: genreUrl);
    }
  }

  Future<void> initGenres() async {
    emit(state.copyWith(isLoadingGenres: true));
    final result = await _getGenres();

    result.when(
      success: (value) => emit(
        state.copyWith(
          isLoadingGenres: false,
          genres: value.top.getRange(0, 4).toList(),
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          isLoadingGenres: false,
          error: error,
        ),
      ),
    );
  }

  Future<void> requestTopArtists({String genreUrl = ""}) async {
    if (!state.isLoadingArtists) {
      emit(
        state.copyWith(isLoadingArtists: true),
      );
    }

    final topArtistsResult = await _getTopArtists(
      genreUrl: genreUrl,
    );

    emit(
      state.copyWith(
        isLoadingArtists: false,
        topArtists: topArtistsResult.isSuccess ? topArtistsResult.get()!.items : [],
        error: topArtistsResult.getError(),
      ),
    );
  }
}
