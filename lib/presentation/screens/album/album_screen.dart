import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/album/album_bloc.dart';
import 'package:cifraclub/presentation/screens/album/album_state.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key, required this.name});

  final String name;

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  late AlbumBloc _bloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AlbumBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumState>(
      bloc: _bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: CosmosAppBar(
            title: Text(widget.name),
          ),
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              //todo: album header
              if (state.isLoading)
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: context.appDimensionScheme.screenMargin,
                      ),
                      const Center(child: CircularProgressIndicator())
                    ],
                  ),
                )
              else if (state.error != null)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ErrorDescriptionWidget(
                        typeError: state.error is ConnectionError
                            ? ErrorDescriptionWidgetType.connection
                            : ErrorDescriptionWidgetType.server,
                        // coverage:ignore-start
                        onClick: () => _bloc.init(),
                        // coverage:ignore-end
                      ),
                    ],
                  ),
                )
              else ...[
                for (var disc in state.discs) ...[
                  if (state.discs.length > 1)
                    SliverPadding(
                      padding: EdgeInsets.all(context.appDimensionScheme.screenMargin),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          context.text.disc(state.discs.indexOf(disc) + 1),
                          style: context.typography.title5,
                        ),
                      ),
                    ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: disc.songs.length,
                      (context, index) {
                        final discSong = disc.songs[index];
                        final artistSong = discSong.artistSong;
                        final isEnable = artistSong != null &&
                            (artistSong.guitar > 0 ||
                                artistSong.bass > 0 ||
                                artistSong.harmonica > 0 ||
                                artistSong.drums > 0);
                        return ArtistSongItem(
                          onTap: () {},
                          onOptionsTap: () {},
                          name: discSong.name,
                          ranking: discSong.order,
                          isVerified: artistSong?.verified ?? false,
                          hasVideoLessons: artistSong?.videoLessons != null ? artistSong!.videoLessons > 0 : false,
                          isEnable: isEnable,
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: context.appDimensionScheme.highlightCardBorderRadius,
                    ),
                  ),
                ]
              ]
            ],
          ),
        );
      },
    );
  }
}
