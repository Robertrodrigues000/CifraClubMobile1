// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/artist/artist_bloc.dart';
import 'package:cifraclub/presentation/screens/artist/artist_state.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_header.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_title.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/albums.dart';
import 'package:cifraclub/presentation/widgets/buttons/button_type.dart';
import 'package:cifraclub/presentation/widgets/buttons/cifra_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({super.key, required this.name});
  final String name;
  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  late ArtistBloc _bloc;
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ArtistBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.getArtistSongs();
    _bloc.getArtistInfo();
    _bloc.getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistBloc, ArtistState>(
      bloc: _bloc,
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              ArtistHeader(
                scrollController: _scrollController,
                maxOffset: context.appDimensionScheme.artistHeaderHeight - 56,
                isLoading: _bloc.state.isLoading,
                onFavorite: () {},
                onShare: () {},
                genreName: state.artistInfo?.genre.name ?? "",
                artistName: state.artistInfo?.name ?? "",
                image: state.artistInfo?.headImageDto?.image ?? state.artistInfo?.imagesDto?.size250 ?? "",
                color: state.artistInfo?.headImageDto?.color ?? state.artistInfo?.imagesDto?.color ?? "",
              ),
              ArtistSectionTitle(
                title: context.text.mostAccessed,
                top: context.appDimensionScheme.screenMargin,
                bottom: context.appDimensionScheme.screenMargin,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.songs.length,
                  (context, index) => ArtistSongItem(
                    onTap: () {},
                    onOptionsTap: () {},
                    name: state.songs[index].name,
                    ranking: index + 1,
                    isVerified: state.songs[index].verified,
                    hasVideolessons: state.songs[index].videoLessons > 0,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: CifraButton(
                  type: ButtonType.outline,
                  // coverage:ignore-start
                  onPressed: () {},
                  // coverage:ignore-end
                  padding: EdgeInsets.only(
                    left: context.appDimensionScheme.screenMargin,
                    right: context.appDimensionScheme.screenMargin,
                    top: 16,
                    bottom: 32,
                  ),
                  child: Text(context.text.artistMoreSongs),
                ),
              ),
              if (state.albums.isNotEmpty) ...[
                ArtistSectionTitle(
                  title: context.text.albums,
                  bottom: context.appDimensionScheme.screenMargin,
                ),
                Albums(albums: state.albums),
                SliverToBoxAdapter(
                  child: CifraButton(
                    type: ButtonType.outline,
                    // coverage:ignore-start
                    onPressed: () {},
                    // coverage:ignore-end
                    padding: EdgeInsets.only(
                      left: context.appDimensionScheme.screenMargin,
                      right: context.appDimensionScheme.screenMargin,
                      top: context.appDimensionScheme.screenMargin,
                      bottom: 32,
                    ),
                    child: Text(context.text.moreAlbums),
                  ),
                )
              ],
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
