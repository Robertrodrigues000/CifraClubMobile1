import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/presentation/screens/genres/genres_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class GenresBloc extends Cubit<GenresState> {
  final GetGenres getGenres;

  GenresBloc({required this.getGenres}) : super(GenresInitialState());

  Future<void> requestGenres() async {
    if (state is GenresLoadingState) {
      return;
    }

    emit(GenresLoadingState());

    var genresResult = await getGenres();

    genresResult.when(
      success: (allGenres) => emit(GenresLoadedState(allGenres.top + allGenres.all)),
      failure: (error) => emit(GenresErrorState(error)),
    );
  }
}
