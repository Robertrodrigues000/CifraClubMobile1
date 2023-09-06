import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/youtube/use_cases/get_youtube_videos.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet_state.dart';
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

  const ListenBottomSheet(this._getYouTubeVideos);

  // coverage:ignore-start
  void open({
    required BuildContext context,
    ListenBottomSheetBloc? bloc,
  }) {
    DefaultBottomSheet.showBottomSheet(
      context: context,
      child: _ListenBottomSheetWidget(
        bloc: bloc ??
            ListenBottomSheetBloc(
              _getYouTubeVideos,
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
  var isScrolledUnder = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  // coverage:ignore-start
  void _onScroll() {
    final currentOffset = _scrollController.offset;
    final currentScrollUnder = currentOffset > 0 ? true : false;
    if (currentScrollUnder != isScrolledUnder) {
      setState(() {
        isScrolledUnder = currentScrollUnder;
      });
    }
  }
  // coverage:ignore-end

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _tabController.dispose();
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
              DefaultBottomSheetHeader(isScrolledUnder: isScrolledUnder),
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: Container(
                          color: isScrolledUnder ? context.colors.neutralSecondary : context.colors.neutralPrimary,
                          padding: EdgeInsets.only(
                            right: context.appDimensionScheme.screenMargin,
                            left: context.appDimensionScheme.screenMargin,
                            bottom: context.appDimensionScheme.screenMargin,
                          ),
                          child: Text(context.text.listen, style: context.typography.title5),
                        ),
                      ),
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        sliver: _ListenBottomSheetFixedHeader(
                          haveScroll: isScrolledUnder,
                          tabController: _tabController,
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
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return LibrarySongTile(
                                      imageUrl: "",
                                      artistName: "Legião Urbana",
                                      songName: "Quase sem querer (Aula de violão)",
                                      onTap: () {}, // coverage:ignore-line
                                    );
                                  },
                                  childCount: 20, // Number of containers in the list
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
  const _ListenBottomSheetFixedHeader({required this.haveScroll, required this.tabController});
  final bool haveScroll;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _ListenBottomSheetFixedHeaderDelegate(
        haveScroll: haveScroll,
        maxExtend: 52,
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
  final bool haveScroll;

  _ListenBottomSheetFixedHeaderDelegate({required this.maxExtend, required this.child, required this.haveScroll});

  @override
  double get maxExtent => maxExtend;

  @override
  double get minExtent => maxExtend;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtend,
      color: haveScroll ? context.colors.neutralSecondary : context.colors.neutralPrimary,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! _ListenBottomSheetFixedHeaderDelegate ||
        oldDelegate.haveScroll != haveScroll ||
        oldDelegate.child != child;
  }
}
