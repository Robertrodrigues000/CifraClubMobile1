import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:cifraclub/presentation/screens/album/album_bloc.dart';
import 'package:cifraclub/presentation/screens/album/album_state.dart';
import 'package:cifraclub/presentation/screens/album/widgets/album_header.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:cifraclub/presentation/screens/version/version_entry.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key, required this.versionOptionsBottomSheet});
  final VersionOptionsBottomSheet versionOptionsBottomSheet;

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  late final AlbumBloc _bloc = BlocProvider.of<AlbumBloc>(context);
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumState>(
      bloc: _bloc,
      builder: (_, state) {
        return Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              AlbumHeader(
                scrollController: _scrollController,
                maxOffset: context.appDimensionScheme.albumHeaderHeight - context.appDimensionScheme.appBarHeight,
                onShare: () async {
                  final box = context.findRenderObject() as RenderBox?;
                  final rect = box != null ? box.localToGlobal(Offset.zero) & box.size : null;
                  final link = AppUrls.albumUrlFormat(state.album?.artistUrl ?? "", state.album?.albumUrl ?? "");
                  await _bloc.shareLink(link, rect);
                },
                artistName: state.album?.artistName ?? "",
                albumName: state.album?.title ?? "",
                image: state.album?.image?.thumb ?? "",
                color: state.album?.image?.color ?? "",
                isLoading: state.isLoading,
                isError: state.error != null,
                albumThumbSize: context.appDimensionScheme.albumHeaderThumbHeight,
                totalSongs: state.album?.totalSongs ?? 0,
                releaseYear: state.album?.releaseYear,
              ),
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
                      (_, index) {
                        final discSong = disc.songs[index];
                        final artistSong = discSong.artistSong;
                        final isEnable = artistSong != null &&
                            (artistSong.guitar > 0 ||
                                artistSong.bass > 0 ||
                                artistSong.harmonica > 0 ||
                                artistSong.drums > 0);
                        return ArtistSongItem(
                          onTap: () {
                            VersionEntry.pushFromSong(
                              Nav.of(context),
                              state.album?.artistUrl ?? "",
                              disc.songs[index].artistSong?.url ?? "",
                              state.album?.artistName ?? "",
                              discSong.name,
                            );
                          },
                          onOptionsTap: () async {
                            await widget.versionOptionsBottomSheet.show(
                              context: context,
                              artistUrl: state.album?.artistUrl ?? "",
                              songUrl: disc.songs[index].artistSong?.url ?? "",
                              songId: discSong.id,
                            );
                          },
                          name: discSong.name,
                          prefix: (discSong.order).toString(),
                          isVerified: artistSong?.verified ?? false,
                          hasVideoLessons: artistSong?.videoLessons != null ? artistSong!.videoLessons > 0 : false,
                          isEnable: isEnable,
                        );
                      },
                    ),
                  ),
                ],
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: SizedBox(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: context.appDimensionScheme.albumHeaderHeight - context.appDimensionScheme.appBarHeight,
                  ),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
