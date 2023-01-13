// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

import 'package:cifraclub/domain/artist/use_cases/get_top_artists.dart';
import 'package:cifraclub/presentation/screens/genre/genre_state.dart';

class GenreBloc extends Cubit<GenreState> {
  final GetTopArtists getTopArtists;
  final String genreUrl;
  final String? genreName;

  GenreBloc({
    required this.getTopArtists,
    required this.genreUrl,
    this.genreName,
  }) : super(GenreLoadingState());

  Future<void> requestTopArtists() async {
    var topArtistsResult = await getTopArtists(
      genreUrl: genreUrl,
    );
    topArtistsResult.when(
      success: (list) {
        if (list.items.isEmpty) {
          emit(GenreErrorState(ServerError()));
        } else {
          emit(GenreLoadedState(
            artists: list.items,
            genreName: genreName ?? list.items.first.genre.name,
          ));
        }
      },
      failure: (error) => emit(GenreErrorState(error)),
    );
  }
}
