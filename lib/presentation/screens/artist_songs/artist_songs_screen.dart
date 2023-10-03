import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_page.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_state.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_video_lesson_item.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_songs_fixed_header.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_songs_collapsed_header.dart';
import 'package:cifraclub/presentation/screens/version/version_entry.dart';
import 'package:collection/collection.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cosmos/cosmos.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';

class ArtistSongsScreen extends StatefulWidget {
  const ArtistSongsScreen({super.key, required this.artistName, required this.versionOptionsBottomSheet});
  final String artistName;
  final VersionOptionsBottomSheet versionOptionsBottomSheet;

  @override
  State<ArtistSongsScreen> createState() => _ArtistSongsScreenState();
}

class _ArtistSongsScreenState extends State<ArtistSongsScreen> with SingleTickerProviderStateMixin {
  late final ArtistSongsBloc _bloc = BlocProvider.of<ArtistSongsBloc>(context);
  late TabController _tabController;
  final scrollController = ScrollController();
  var isScrolledUnder = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    scrollController.addListener(_onScroll);
    _tabController.addListener(_onPageChange);
  }

  void _onPageChange() {
    _bloc.onPageChange(ArtistSongsPage.fromIndex(_tabController.index));
  }

  void _onScroll() {
    final currentOffset = scrollController.offset;
    final oldScrolledUnder = isScrolledUnder;
    isScrolledUnder = currentOffset > 0 ? true : false;
    if (oldScrolledUnder != isScrolledUnder) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    _tabController.removeListener(_onPageChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistSongsBloc, ArtistSongsState>(
      bloc: _bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: CosmosAppBar(
            title: Text(
              context.text.songs(2),
              style: context.typography.title4.copyWith(color: context.colors.textPrimary),
            ),
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: EdgeInsets.only(left: context.appDimensionScheme.appBarMargin),
              child: InkWell(
                onTap: () => Nav.of(context).pop(),
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: SvgPicture.asset(
                    AppSvgs.backArrowIcon,
                    fit: BoxFit.none,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
          body: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: ArtistSongsCollapsedHeader(
                      isScrolledUnder: isScrolledUnder,
                      artist: widget.artistName,
                      filter: state.instrument?.getInstrumentName(context) ?? context.text.all,
                      totalSongs: state.songs.length),
                ),
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: ArtistSongsFixedHeader(
                      isScrolledUnder: isScrolledUnder,
                      tabController: _tabController,
                      onSearchStringChanged: _bloc.onSearchStringChanged,
                      shouldShowSearch: state.shouldShowSearch,
                    ),
                  ),
                ),
              ];
            },
            body: Builder(builder: (context) {
              return TabBarView(
                physics: const PageScrollPhysics(),
                controller: _tabController,
                children: <Widget>[
                  SafeArea(
                    top: false,
                    bottom: false,
                    child: Builder(builder: (context) {
                      return CustomScrollView(
                        slivers: [
                          SliverOverlapInjector(
                            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                          ),
                          if (state.songsError != null)
                            SliverFillRemaining(
                              child: Center(
                                child: SingleChildScrollView(
                                  child: ErrorDescriptionWidget(
                                    typeError: state.songsError! is ConnectionError
                                        ? ErrorDescriptionWidgetType.connection
                                        : ErrorDescriptionWidgetType.server,
                                    onClick: () => _bloc.getArtistSongsAndVideoLessons(),
                                  ),
                                ),
                              ),
                            )
                          else if (state.isLoading)
                            const SliverFillRemaining(child: Center(child: LoadingIndicator()))
                          else if (state.songsFilteredBySearch.isNotEmpty)
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: state.songsFilteredBySearch.length,
                                (context, index) {
                                  final song = state.songsFilteredBySearch[index];
                                  return ArtistSongItem(
                                      onTap: () {
                                        VersionEntry.pushFromSong(
                                          Nav.of(context),
                                          _bloc.artistUrl ?? "",
                                          song.url,
                                          widget.artistName,
                                          song.name,
                                        );
                                      },
                                      onOptionsTap: () async {
                                        await widget.versionOptionsBottomSheet.show(
                                          context: context,
                                          artistUrl: _bloc.artistUrl ?? "",
                                          songUrl: song.url,
                                          songId: song.id,
                                        );
                                      },
                                      name: song.name,
                                      prefix: state.rankingPrefixes[index],
                                      isVerified: song.verified,
                                      hasVideoLessons: _hasInstrumentVideoLesson(state.instrument, song));
                                },
                              ),
                            )
                          else
                            SliverPadding(
                              padding: EdgeInsets.only(top: context.appDimensionScheme.artistSongsHeaderSpace),
                              sliver: const SliverToBoxAdapter(
                                child: ErrorDescriptionWidget(
                                  typeError: ErrorDescriptionWidgetType.resultNotFound,
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                  SafeArea(
                    top: false,
                    bottom: false,
                    child: Builder(builder: (context) {
                      final alphabeticalSongs =
                          state.songsFilteredBySearch.sortedBy((a) => removeDiacritics(a.name).toLowerCase());
                      return CustomScrollView(
                        slivers: [
                          SliverOverlapInjector(
                            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                          ),
                          if (state.songsError != null)
                            SliverFillRemaining(
                              child: Center(
                                child: SingleChildScrollView(
                                  child: ErrorDescriptionWidget(
                                    typeError: state.songsError! is ConnectionError
                                        ? ErrorDescriptionWidgetType.connection
                                        : ErrorDescriptionWidgetType.server,
                                    onClick: () => _bloc.getArtistSongsAndVideoLessons(),
                                  ),
                                ),
                              ),
                            )
                          else if (state.isLoading)
                            const SliverFillRemaining(child: Center(child: LoadingIndicator()))
                          else if (alphabeticalSongs.isNotEmpty)
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: alphabeticalSongs.length,
                                (context, index) {
                                  final song = alphabeticalSongs[index];
                                  return ArtistSongItem(
                                      // coverage:ignore-start
                                      onTap: () {
                                        VersionEntry.pushFromSong(
                                          Nav.of(context),
                                          _bloc.artistUrl ?? "",
                                          song.url,
                                          widget.artistName,
                                          song.name,
                                        );
                                      },
                                      onOptionsTap: () async {
                                        await widget.versionOptionsBottomSheet.show(
                                          context: context,
                                          artistUrl: _bloc.artistUrl ?? "",
                                          songUrl: song.url,
                                          songId: song.id,
                                        );
                                      },
                                      // coverage:ignore-end
                                      name: song.name,
                                      prefix: state.alphabeticalPrefixes[index],
                                      isVerified: song.verified,
                                      hasVideoLessons: _hasInstrumentVideoLesson(state.instrument, song));
                                },
                              ),
                            )
                          else
                            SliverPadding(
                              padding: EdgeInsets.only(top: context.appDimensionScheme.artistSongsHeaderSpace),
                              sliver: const SliverToBoxAdapter(
                                child: ErrorDescriptionWidget(
                                  typeError: ErrorDescriptionWidgetType.resultNotFound,
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                  SafeArea(
                    top: false,
                    bottom: false,
                    child: Builder(builder: (context) {
                      return CustomScrollView(slivers: [
                        SliverOverlapInjector(
                          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                        ),
                        if (state.videoLessonsError != null)
                          SliverFillRemaining(
                            child: Center(
                              child: SingleChildScrollView(
                                child: ErrorDescriptionWidget(
                                  typeError: state.videoLessonsError! is ConnectionError
                                      ? ErrorDescriptionWidgetType.connection
                                      : ErrorDescriptionWidgetType.server,
                                  onClick: () => _bloc.getArtistSongsAndVideoLessons(),
                                ),
                              ),
                            ),
                          )
                        else if (state.isLoading)
                          const SliverFillRemaining(child: Center(child: LoadingIndicator()))
                        else if (state.videoLessons.isEmpty)
                          const SliverFillRemaining(
                            child: Center(
                              child: SingleChildScrollView(
                                child: ErrorDescriptionWidget(
                                  typeError: ErrorDescriptionWidgetType.videoLesson,
                                ),
                              ),
                            ),
                          )
                        else if (state.videoLessonsFilteredBySearch.isEmpty)
                          SliverPadding(
                            padding: EdgeInsets.only(top: context.appDimensionScheme.artistSongsHeaderSpace),
                            sliver: const SliverToBoxAdapter(
                              child: SingleChildScrollView(
                                child: ErrorDescriptionWidget(
                                  typeError: ErrorDescriptionWidgetType.resultNotFound,
                                ),
                              ),
                            ),
                          )
                        else
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: state.videoLessonsFilteredBySearch.length,
                              (context, index) {
                                final videoLesson = state.videoLessonsFilteredBySearch[index];
                                return ArtistVideoLessonItem(
                                  onTap: () {},
                                  imageUrl: videoLesson.images.small,
                                  artistName: videoLesson.artist?.name ?? "",
                                  title: videoLesson.title,
                                  views: videoLesson.views,
                                  duration: videoLesson.duration,
                                  versionLabel: videoLesson.version?.label ?? "",
                                );
                              },
                            ),
                          ),
                      ]);
                    }),
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }

  bool _hasInstrumentVideoLesson(Instrument? instrument, ArtistSong song) {
    if (instrument == null && song.videoLessons > 0) {
      return true;
    } else {
      return song.videoLessonsInstruments?.contains(instrument) ?? false;
    }
  }
}
