import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/genre/use_cases/get_genres.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/genres/widgets/genres_list.dart';
import 'package:cifraclub/presentation/widgets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/genres_bottom_sheet/genre_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/widgets/genres_bottom_sheet/genre_bottom_sheet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// coverage:ignore-file
class GenreBottomSheet {
  final GetGenres _getGenres;

  GenreBottomSheet(this._getGenres);

  Future<Genre?> open(BuildContext context) {
    return _showGenreBottomSheet(context, GenreBottomSheetBloc(_getGenres));
  }

  Future<Genre?> _showGenreBottomSheet(
    BuildContext context,
    GenreBottomSheetBloc bloc,
  ) {
    final scrollController = ScrollController();
    bloc.requestGenres();

    return DefaultBottomSheet.showBottomSheet(
      child: BlocProvider(
        create: (context) => bloc,
        child: BlocBuilder<GenreBottomSheetBloc, GenreBottomSheetState>(builder: (context, state) {
          if (state is GenreBottomSheetLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GenreBottomSheetLoadedState) {
            return GenresList(
              genres: state.genres,
              onTap: (genre) {
                Navigator.of(context).pop<Genre>(genre);
              },
              padding: EdgeInsets.only(bottom: context.appDimensionScheme.bottomSheetContentToBottom),
              scrollController: scrollController,
            );
          } else {
            return Container(); //TODO: Verificar para colocar uma mensagem de erro nas bottom sheets
          }
        }),
      ),
      context: context,
      scrollController: scrollController,
      heightMaxFactor: .8,
    );
  }
}
