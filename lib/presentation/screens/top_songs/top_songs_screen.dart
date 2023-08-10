import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_state.dart';
import 'package:cifraclub/presentation/screens/top_songs/widgets/top_songs.dart';
import 'package:cifraclub/presentation/screens/version/version_entry.dart';
import 'package:cifraclub/presentation/widgets/genres_capsule/genres_capsule.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class TopSongsScreen extends StatefulWidget {
  const TopSongsScreen(this._genreBottomSheet, {super.key});
  final GenreBottomSheet _genreBottomSheet;

  @override
  State<TopSongsScreen> createState() => _TopSongsScreenState();
}

class _TopSongsScreenState extends State<TopSongsScreen> {
  late final TopSongsBloc _bloc = BlocProvider.of<TopSongsBloc>(context);

  @override
  Widget build(BuildContext context) {
    final dimensions = context.appDimensionScheme;
    return Scaffold(
      appBar: CosmosAppBar(
        title: Text(context.text.topSongs),
      ),
      body: BlocBuilder<TopSongsBloc, TopSongsState>(
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
                  if (state.isLoadingSongs) {
                    return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
                  } else if (state.error != null) {
                    return const SliverFillRemaining(child: Center(child: Text("Erro")));
                  } else {
                    return TopSongs(
                      topSongs: state.topSongs,
                      // coverage:ignore-start
                      onTap: (song) => VersionEntry.pushFromSong(Nav.of(context), song.artist?.url ?? "", song.url,
                          song.artist?.name ?? "", song.name), // coverage:ignore-end
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
