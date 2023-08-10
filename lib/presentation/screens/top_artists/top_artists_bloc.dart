// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart';
import 'package:cifraclub/domain/genre/use_cases/insert_user_genre.dart';
import 'package:cifraclub/domain/shared/paginated_list.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_state.dart';
import 'package:cifraclub/presentation/widgets/genres_capsule/genres_capsule_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart';

class TopArtistsBloc extends Cubit<TopArtistsState> with GenresCapsuleMixin {
  final GetTopArtists _getTopArtists;
  CancelableOperation<Result<PaginatedList<Artist>, RequestError>>? currentRequest;

  @override
  final GetUserGenresAsStream getUserGenresAsStream;

  @override
  final InsertUserGenre insertUserGenre;

  TopArtistsBloc(
    this._getTopArtists,
    this.getUserGenresAsStream,
    this.insertUserGenre,
  ) : super(TopArtistsState());

  void init() {
    initGenres();
    requestTopArtists();
  }

  @override
  void emitGenres(List<Genre> genres) async {
    emit(state.copyWith(genres: genres));
    if (state.selectedGenre != null && genres.every((element) => element.url != state.selectedGenre)) {
      emit(state.copyWith(selectedGenre: null));
      await requestTopArtists();
    }
  }

  @override
  void newGenre(Genre genre) async {
    emit(state.copyWith(selectedGenre: genre.url));
    await requestTopArtists(genreUrl: genre.url);
  }

  void onGenreSelected(String? genreUrl) async {
    if (genreUrl != state.selectedGenre) {
      emit(state.copyWith(selectedGenre: genreUrl));
      await requestTopArtists(genreUrl: genreUrl);
    }
  }

  Future<void> requestTopArtists({String? genreUrl = ""}) async {
    if (!state.isLoadingArtists) {
      emit(
        state.copyWith(isLoadingArtists: true),
      );
    }

    currentRequest?.cancel();
    currentRequest = _getTopArtists(
      genreUrl: genreUrl,
    );

    var topArtistsResult = (await currentRequest!.valueOrCancellation(Err(RequestCancelled())))!;
    if (topArtistsResult.getError() is RequestCancelled) {
      return;
    }
    emit(
      state.copyWith(
        isLoadingArtists: false,
        topArtists: topArtistsResult.isSuccess ? topArtistsResult.get()!.items : [],
        error: topArtistsResult.getError(),
      ),
    );
  }
}
