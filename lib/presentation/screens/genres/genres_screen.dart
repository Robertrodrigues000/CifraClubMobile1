import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/genres/genres_bloc.dart';
import 'package:cifraclub/presentation/screens/genres/genres_state.dart';
import 'package:cifraclub/presentation/screens/genres/widgets/genres_list.dart';
import 'package:cifraclub/presentation/screens/genres/widgets/request_genres.dart';
import 'package:flutter/material.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.text.genreScreen),
      ),
      body: BlocBuilder<GenresBloc, GenresState>(
        builder: (context, state) {
          if (state is GenresLoadedState) {
            return GenresList(genres: state.genres);
          } else {
            return RequestGenres(
              stateString: _getStateMessage(context, state),
              state: state,
            );
          }
        },
      ),
    );
  }

  String _getStateMessage(BuildContext context, GenresState state) {
    switch (state.runtimeType) {
      case GenresInitialState:
        return context.text.pressTheButtonToGetGenres;
      case GenresLoadingState:
        return context.text.loading;
      case GenresErrorState:
        return (state as GenresErrorState).error is ConnectionError ? context.text.noConnection : context.text.failToLoad;
      case GenresLoadedState:
        return "";
      default:
        return context.text.failToLoad;
    }
  }
}
