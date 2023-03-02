// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/domain/song/use_cases/get_top_songs.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_state/top_songs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class TopSongsBloc extends Cubit<TopSongsState> {
  final GetTopSongs _getTopSongs;
  final GetGenres _getGenres;

  TopSongsBloc(
    this._getTopSongs,
    this._getGenres,
  ) : super(TopSongsState(selectedGenre: "todos"));

  Future<void> onGenreSelected(String genreUrl) async {
    if (state.selectedGenre != genreUrl) {
      emit(state.copyWith(selectedGenre: genreUrl));
      await requestTopSongs(genreUrl: genreUrl);
    }
  }

  Future<void> initGenres() async {
    emit(state.copyWith(isLoadingGenres: true));
    final result = await _getGenres();

    result.when(
      success: (value) => emit(
        state.copyWith(
          genres: value.top.getRange(0, 4).toList(),
          isLoadingGenres: false,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          error: error,
          isLoadingGenres: false,
        ),
      ),
    );
  }

  Future<void> requestTopSongs({String genreUrl = ""}) async {
    if (!state.isLoadingSongs) {
      emit(
        state.copyWith(isLoadingSongs: true),
      );
    }
    final topSongsResult = await _getTopSongs(
      genreUrl: genreUrl,
    );

    emit(
      state.copyWith(
        isLoadingSongs: false,
        topSongs: topSongsResult.isSuccess ? topSongsResult.get()!.items : [],
        error: topSongsResult.getError(),
      ),
    );
  }
}
