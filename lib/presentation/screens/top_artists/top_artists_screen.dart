import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_bloc.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_state/top_artists_state.dart';
import 'package:cifraclub/presentation/screens/top_artists/widgets/top_artists.dart';
import 'package:cifraclub/presentation/widgets/cosmos_app_bar.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopArtistsScreen extends StatefulWidget {
  const TopArtistsScreen({super.key});

  @override
  State<TopArtistsScreen> createState() => _TopArtistsScreenState();
}

class _TopArtistsScreenState extends State<TopArtistsScreen> {
  late final TopArtistsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<TopArtistsBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.initGenres();
    bloc.requestTopArtists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CosmosAppBar(
        title: Text(context.text.topArtists),
      ),
      body: BlocBuilder<TopArtistsBloc, TopArtistsState>(
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
                    if (state.isLoadingArtists) {
                      return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
                    } else if (state.error != null) {
                      return const SliverFillRemaining(child: Center(child: Text("Erro")));
                    } else {
                      return TopArtists(
                        topArtists: state.topArtists, onTap: (artist) {}, //TODO navegar para tela de cifra,
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
