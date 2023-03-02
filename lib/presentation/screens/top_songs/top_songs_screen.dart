import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_state/top_songs_state.dart';
import 'package:cifraclub/presentation/screens/top_songs/widgets/top_songs.dart';
import 'package:cifraclub/presentation/widgets/cosmos_app_bar.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopSongsScreen extends StatefulWidget {
  const TopSongsScreen({super.key});

  @override
  State<TopSongsScreen> createState() => _TopSongsScreenState();
}

class _TopSongsScreenState extends State<TopSongsScreen> {
  late final TopSongsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<TopSongsBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.initGenres();
    bloc.requestTopSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CosmosAppBar(
        title: Text(context.text.topSongs),
      ),
      body: BlocBuilder<TopSongsBloc, TopSongsState>(
        bloc: bloc,
        builder: (context, state) => Builder(
          builder: (context) {
            if (state.isLoadingGenres) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return CustomScrollView(
                slivers: [
                  if (state.genres.isNotEmpty)
                    SliverToBoxAdapter(
                      child: FilterCapsuleList(
                          capsulePadding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
                          filters: [
                            ...state.genres
                                .map(
                                  (genre) => Filter(
                                    label: genre.name,
                                    onTap: () {
                                      bloc.onGenreSelected(genre.url);
                                    },
                                    isSelected: state.selectedGenre == genre.url,
                                  ),
                                )
                                .toList()
                          ]),
                    ),
                  Builder(builder: (context) {
                    if (state.isLoadingSongs) {
                      return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
                    } else if (state.error != null) {
                      return const SliverFillRemaining(child: Center(child: Text("Erro")));
                    } else {
                      return TopSongs(
                        topSongs: state.topSongs, onTap: (song) {}, //TODO navegar para tela de cifra,
                        selectedGenre: state.selectedGenre,
                      );
                    }
                  }),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
