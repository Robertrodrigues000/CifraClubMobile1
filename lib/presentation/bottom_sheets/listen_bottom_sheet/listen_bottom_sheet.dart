import 'dart:typed_data';

import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/song/models/song_search_error.dart';
import 'package:cifraclub/domain/song/use_cases/get_local_song_image.dart';
import 'package:cifraclub/domain/song/use_cases/get_local_songs.dart';
import 'package:cifraclub/domain/youtube/use_cases/get_youtube_videos.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet_state.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/widgets/controller_scroll_under_builder.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/widgets/library_song_tile.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/widgets/youtube_video_tile.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class ListenBottomSheet {
  final GetYouTubeVideos _getYouTubeVideos;
  final GetLocalSongs _getLocalSongs;
  final GetLocalSongImage _getLocalSongImage;

  const ListenBottomSheet(this._getYouTubeVideos, this._getLocalSongImage, this._getLocalSongs);

  // coverage:ignore-start
  void open({
    required BuildContext context,
    required String artistName,
    required String songName,
    ListenBottomSheetBloc? bloc,
  }) {
    DefaultBottomSheet.showBottomSheet(
      context: context,
      child: _ListenBottomSheetWidget(
        bloc: bloc ??
            ListenBottomSheetBloc(
              _getYouTubeVideos,
              _getLocalSongs,
              _getLocalSongImage,
              artistName: artistName,
              songName: songName,
            ),
      ),
      enableHeader: false,
      heightMaxFactor: 0.8,
    );
  }
  // coverage:ignore-end
}

class _ListenBottomSheetWidget extends StatefulWidget {
  const _ListenBottomSheetWidget({required this.bloc});

  final ListenBottomSheetBloc bloc;

  @override
  State<_ListenBottomSheetWidget> createState() => _ListenBottomSheetWidgetState();
}

class _ListenBottomSheetWidgetState extends State<_ListenBottomSheetWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var isFirstCall = true;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onPageChange);
  }

  void _onPageChange() {
    if (_tabController.index == 1 && isFirstCall) {
      isFirstCall = false;
      widget.bloc.getLocalSongs();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(_onPageChange);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.bloc..init(),
      child: BlocBuilder<ListenBottomSheetBloc, ListenBottomSheetState>(
        builder: (context, state) {
          return Column(
            children: [
              ControllerScrollUnderBuilder(
                scrollController: _scrollController,
                builder: (context, isScrolledUnder) {
                  return DefaultBottomSheetHeader(isScrolledUnder: isScrolledUnder);
                },
              ),
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: ControllerScrollUnderBuilder(
                            scrollController: _scrollController,
                            builder: (context, isScrolledUnder) {
                              return Container(
                                color:
                                    isScrolledUnder ? context.colors.neutralSecondary : context.colors.neutralPrimary,
                                padding: EdgeInsets.only(
                                  right: context.appDimensionScheme.screenMargin,
                                  left: context.appDimensionScheme.screenMargin,
                                  bottom: context.appDimensionScheme.screenMargin,
                                ),
                                child: Text(context.text.listen, style: context.typography.title5),
                              );
                            }),
                      ),
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        sliver: _ListenBottomSheetFixedHeader(
                          tabController: _tabController,
                          scrollController: _scrollController,
                        ),
                      ),
                    ];
                  },
                  body: Builder(
                    builder: (context) {
                      return TabBarView(
                        controller: _tabController,
                        children: [
                          CustomScrollView(
                            slivers: [
                              SliverOverlapInjector(
                                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                              ),
                              if (state.youtubeError != null)
                                SliverFillRemaining(
                                  hasScrollBody: false,
                                  child: Center(
                                    child: ErrorDescriptionWidget(
                                      typeError: state.youtubeError! is ConnectionError
                                          ? ErrorDescriptionWidgetType.connection
                                          : ErrorDescriptionWidgetType.server,
                                      onClick: widget.bloc.getYouTubeVideos,
                                    ),
                                  ),
                                )
                              else if (state.isLoadingYoutube)
                                const SliverFillRemaining(child: Center(child: LoadingIndicator()))
                              else if (state.youtubeVideos.isEmpty)
                                SliverToBoxAdapter(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: context.appDimensionScheme.screenMargin),
                                    child: const ErrorDescriptionWidget(
                                      typeError: ErrorDescriptionWidgetType.youtubeResultNotFound,
                                    ),
                                  ),
                                )
                              else
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    childCount: state.youtubeVideos.length,
                                    (BuildContext context, int index) {
                                      final youtubeVideo = state.youtubeVideos[index];

                                      return YouTubeVideoTile(
                                        duration: youtubeVideo.duration,
                                        imageUrl: youtubeVideo.imageUrl,
                                        videoName: youtubeVideo.title,
                                        views:
                                            "${_formatNumber(int.tryParse(youtubeVideo.viewCount))} ${context.text.views}",
                                        onTap: () {}, // coverage:ignore-line
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                          CustomScrollView(
                            slivers: [
                              SliverOverlapInjector(
                                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                              ),
                              if (state.isLoadingLocalSongs)
                                const SliverFillRemaining(child: Center(child: LoadingIndicator()))
                              else if (state.localSongsError != null ||
                                  (state.localSongs != null && state.localSongs!.isEmpty))
                                SliverToBoxAdapter(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: context.appDimensionScheme.screenMargin),
                                    child: ErrorDescriptionWidget(
                                      typeError: state.localSongsError is SongPermissionError
                                          ? ErrorDescriptionWidgetType.localSongsPermissionDenied
                                          : ErrorDescriptionWidgetType.localSongsResultNotFound,
                                    ),
                                  ),
                                )
                              else if (state.localSongs != null)
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    childCount: state.localSongs!.length,
                                    (BuildContext context, int index) {
                                      final localSong = state.localSongs![index];

                                      return FutureBuilder<Uint8List?>(
                                        future: widget.bloc.getImage(localSong.path!),
                                        builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
                                          return LibrarySongTile(
                                            image: snapshot.data,
                                            artistName: localSong.artistName,
                                            songName: localSong.songName,
                                            onTap: () {}, // coverage:ignore-line
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatNumber(int? number) {
    NumberFormat numberFormat = NumberFormat('#,###', 'pt_BR');
    return numberFormat.format(number);
  }
}

class _ListenBottomSheetFixedHeader extends StatelessWidget {
  const _ListenBottomSheetFixedHeader({required this.tabController, required this.scrollController});
  final TabController tabController;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _ListenBottomSheetFixedHeaderDelegate(
        maxExtend: 52,
        scrollController: scrollController,
        child: TabBar(
          controller: tabController,
          labelPadding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: context.colors.primary, width: 2), borderRadius: BorderRadius.circular(3)),
          unselectedLabelColor: context.colors.textSecondary,
          labelStyle: context.typography.subtitle4,
          labelColor: context.colors.textPrimary,
          indicatorSize: TabBarIndicatorSize.tab,
          overlayColor: MaterialStateProperty.resolveWith((_) => Colors.transparent),
          dividerColor: context.colors.neutralTertiary,
          tabs: [
            Tab(
              text: context.text.youtube,
            ),
            Tab(
              text: context.text.library,
            ),
          ],
        ),
      ),
    );
  }
}

class _ListenBottomSheetFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxExtend;
  final Widget child;
  final ScrollController scrollController;

  _ListenBottomSheetFixedHeaderDelegate({required this.maxExtend, required this.scrollController, required this.child});

  bool haveScroll = false;

  @override
  double get maxExtent => maxExtend;

  @override
  double get minExtent => maxExtend;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ControllerScrollUnderBuilder(
      scrollController: scrollController,
      builder: (context, isScrolledUnder) {
        haveScroll = isScrolledUnder;
        return Container(
          height: maxExtend,
          color: haveScroll ? context.colors.neutralSecondary : context.colors.neutralPrimary,
          child: child,
        );
      },
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! _ListenBottomSheetFixedHeaderDelegate ||
        oldDelegate.haveScroll != haveScroll ||
        oldDelegate.child != child;
  }
}
