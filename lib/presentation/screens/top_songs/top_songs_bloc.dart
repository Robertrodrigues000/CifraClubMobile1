// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart';
import 'package:cifraclub/domain/genre/use_cases/insert_user_genre.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/song/models/song.dart';
import 'package:cifraclub/domain/song/use_cases/get_top_songs.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_state.dart';
import 'package:cifraclub/presentation/widgets/genres_capsule/genres_capsule_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class TopSongsBloc extends Cubit<TopSongsState> with GenresCapsuleMixin {
  final GetTopSongs _getTopSongs;
  CancelableOperation<Result<PaginatedList<Song>, RequestError>>? currentRequest;

  @override
  final GetUserGenresAsStream getUserGenresAsStream;

  @override
  final InsertUserGenre insertUserGenre;

  TopSongsBloc(
    this._getTopSongs,
    this.getUserGenresAsStream,
    this.insertUserGenre,
  ) : super(TopSongsState());

  void init() {
    initGenres();
    requestTopSongs();
  }

  @override
  void emitGenres(List<Genre> genres) async {
    emit(state.copyWith(genres: genres));
    if (state.selectedGenre != null && genres.every((element) => element.url != state.selectedGenre)) {
      emit(state.copyWith(selectedGenre: null));
      await requestTopSongs();
    }
  }

  @override
  void newGenre(Genre genre) async {
    emit(state.copyWith(selectedGenre: genre.url));
    await requestTopSongs(genreUrl: genre.url);
  }

  void onGenreSelected(String? genreUrl) async {
    if (genreUrl != state.selectedGenre) {
      emit(state.copyWith(selectedGenre: genreUrl));
      await requestTopSongs(genreUrl: genreUrl);
    }
  }

  Future<void> requestTopSongs({String? genreUrl = ""}) async {
    if (!state.isLoadingSongs) {
      emit(
        state.copyWith(isLoadingSongs: true),
      );
    }

    currentRequest?.cancel();
    currentRequest = _getTopSongs(
      genreUrl: genreUrl,
    );

    var topSongsResult = (await currentRequest!.valueOrCancellation(Err(RequestCancelled())))!;
    if (topSongsResult.getError() is RequestCancelled) {
      return;
    }

    emit(
      state.copyWith(
        isLoadingSongs: false,
        topSongs: topSongsResult.isSuccess ? topSongsResult.get()!.items : [],
        error: topSongsResult.getError(),
      ),
    );
  }
}
