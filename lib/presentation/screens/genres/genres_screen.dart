import 'package:cifraclub/presentation/screens/genre/genre_entry.dart';
import 'package:cifraclub/presentation/screens/genres/genres_bloc.dart';
import 'package:cifraclub/presentation/screens/genres/genres_state.dart';
import 'package:cifraclub/presentation/screens/genres/widgets/genres_list.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  late GenresBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<GenresBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.requestGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CosmosAppBar(
        title: Text(context.text.genreScreen),
      ),
      body: BlocBuilder<GenresBloc, GenresState>(
        builder: (context, state) {
          if (state is GenresLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GenresLoadedState) {
            return GenresList(
              genres: state.genres,
              onTap: (genre) {
                Nav.of(context).push(
                  screenName: GenreEntry.name,
                  params: {GenreEntry.genreUrlParamKey: genre.url, GenreEntry.genreNameParamKey: genre.name},
                );
              },
            );
          } else {
            return const Center(child: Text("Erro"));
          }
        },
      ),
    );
  }
}
