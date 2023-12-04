import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_page.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_state.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_songs_fixed_header.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_songs_collapsed_header.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/songs_by_alphabetical_order_tab.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/songs_by_most_accessed_tab.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/video_lessons_tab.dart';
import 'package:cifraclub/presentation/screens/version/version_entry.dart';
import 'package:cifraclub/presentation/screens/version/full_screen_video/full_screen_video_entry.dart';
import 'package:cosmos/cosmos.dart';
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
  late final _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  final scrollController = ScrollController();
  var isScrolledUnder = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
    _tabController.addListener(_onPageChange);
  }

  void _onPageChange() {
    _bloc.onPageChange(ArtistSongsPage.fromIndex(_tabController.index));
  }

  // coverage:ignore-start
  void _onScroll() {
    final currentOffset = scrollController.offset;
    final oldScrolledUnder = isScrolledUnder;
    isScrolledUnder = currentOffset > 0 ? true : false;
    if (oldScrolledUnder != isScrolledUnder) {
      setState(() {});
    }
  }
  // coverage:ignore-end

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
              style: context.typography.title6,
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
                  SongsByMostAccessedTab(
                    songsFilteredBySearch: state.songsFilteredBySearch,
                    rankingPrefixes: state.rankingPrefixes,
                    songsError: state.songsError,
                    isLoading: state.isLoading,
                    onTapReload: () => _bloc.getArtistSongsAndVideoLessons(),
                    hasVideoLesson: (song) => _hasInstrumentVideoLesson(state.instrument, song),
                    onTapVersion: (song) {
                      VersionEntry.pushFromSong(
                        Nav.of(context),
                        _bloc.artistUrl ?? "",
                        song.url,
                        widget.artistName,
                        song.name,
                      );
                    },
                    onTapVersionOptions: (song) async {
                      await widget.versionOptionsBottomSheet.show(
                        context: context,
                        artistUrl: _bloc.artistUrl ?? "",
                        songUrl: song.url,
                        songId: song.id,
                      );
                    },
                  ),
                  SongsByAlphabeticalOrderTab(
                    songsFilteredBySearch: state.songsFilteredBySearch,
                    alphabeticalPrefixes: state.alphabeticalPrefixes,
                    songsError: state.songsError,
                    isLoading: state.isLoading,
                    onTapReload: () => _bloc.getArtistSongsAndVideoLessons(),
                    hasVideoLesson: (song) => _hasInstrumentVideoLesson(state.instrument, song),
                    onTapVersion: (song) {
                      VersionEntry.pushFromSong(
                        Nav.of(context),
                        _bloc.artistUrl ?? "",
                        song.url,
                        widget.artistName,
                        song.name,
                      );
                    },
                    onTapVersionOptions: (song) async {
                      await widget.versionOptionsBottomSheet.show(
                        context: context,
                        artistUrl: _bloc.artistUrl ?? "",
                        songUrl: song.url,
                        songId: song.id,
                      );
                    },
                  ),
                  VideoLessonsTab(
                    videoLessons: state.videoLessons,
                    videoLessonsFilteredBySearch: state.videoLessonsFilteredBySearch,
                    isLoading: state.isLoading,
                    videoLessonsError: state.videoLessonsError,
                    onTapReload: () => _bloc.getArtistSongsAndVideoLessons(),
                    onTapVideoLesson: (videoLesson) {
                      if (videoLesson.version == null) {
                        FullScreenVideoEntry.push(Nav.of(context), videoLesson.youtubeId);
                      } else {
                        VersionEntry.pushFromVideoLesson(
                          Nav.of(context),
                          videoLesson,
                        );
                      }
                    },
                  )
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
