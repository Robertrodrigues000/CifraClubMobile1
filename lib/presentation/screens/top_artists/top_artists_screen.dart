import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/artist/artist_entry.dart';
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_bloc.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_state.dart';
import 'package:cifraclub/presentation/screens/top_artists/widgets/top_artists.dart';
import 'package:cifraclub/presentation/widgets/genres_capsule/genres_capsule.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class TopArtistsScreen extends StatefulWidget {
  const TopArtistsScreen(this._genreBottomSheet, {super.key});

  final GenreBottomSheet _genreBottomSheet;

  @override
  State<TopArtistsScreen> createState() => _TopArtistsScreenState();
}

class _TopArtistsScreenState extends State<TopArtistsScreen> {
  late final TopArtistsBloc _bloc = BlocProvider.of<TopArtistsBloc>(context);

  @override
  Widget build(BuildContext context) {
    final dimensions = context.appDimensionScheme;
    return Scaffold(
      appBar: CosmosAppBar(
        title: Text(context.text.topArtists),
      ),
      body: BlocBuilder<TopArtistsBloc, TopArtistsState>(
        bloc: _bloc,
        builder: (context, state) => Builder(
          builder: (context) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: dimensions.screenMargin),
                    child: GenresCapsule(
                      genres: state.genres,
                      selectedGenre: state.selectedGenre,
                      onGenreSelected: _bloc.onGenreSelected,
                      onMore: () async {
                        final result = await widget._genreBottomSheet.open(context);
                        if (result != null) {
                          _bloc.insertGenre(result);
                          return true;
                        }
                        return false;
                      },
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  if (state.isLoadingArtists) {
                    return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
                  } else if (state.error != null) {
                    return const SliverFillRemaining(child: Center(child: Text("Erro")));
                  } else {
                    return TopArtists(
                      topArtists: state.topArtists,
                      // coverage:ignore-start
                      onTap: (artist) =>
                          ArtistEntry.push(Nav.of(context), artist.url, artist.name), // coverage:ignore-end
                      selectedGenre: state.selectedGenre,
                    );
                  }
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
