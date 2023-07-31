import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_state.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_video_lesson_item.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_songs_fixed_header.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_songs_collapsed_header.dart';
import 'package:collection/collection.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cosmos/cosmos.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';

class ArtistSongsScreen extends StatefulWidget {
  const ArtistSongsScreen({super.key, required this.artistName});
  final String artistName;

  @override
  State<ArtistSongsScreen> createState() => _ArtistSongsScreenState();
}

class _ArtistSongsScreenState extends State<ArtistSongsScreen> with SingleTickerProviderStateMixin {
  late ArtistSongsBloc _bloc;
  final PageController pageController = PageController();
  late TabController _tabController;
  final scrollController = ScrollController();
  var isScrolledUnder = false;
  var shouldShowSearch = true;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ArtistSongsBloc>(context);
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    scrollController.addListener(_onScroll);
    pageController.addListener(_onPageChange);
  }

  void _onPageChange() {
    setState(() {
      shouldShowSearch = pageController.page != 2 || _bloc.state.videoLessons.isNotEmpty;
    });
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
    pageController.removeListener(_onPageChange);
    pageController.dispose();
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
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
                ArtistSongsCollapsedHeader(
                    isScrolledUnder: isScrolledUnder,
                    artist: widget.artistName,
                    filter: state.instrument?.getInstrumentName(context) ?? context.text.all,
                    totalSongs: state.songs.length),
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: ArtistSongsFixedHeader(
                      isScrolledUnder: isScrolledUnder,
                      tabController: _tabController,
                      pageController: pageController,
                      shouldShowSearch: shouldShowSearch,
                    ),
                  ),
                ),
              ];
            },
            body: Builder(builder: (context) {
              return PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
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
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: state.songs.length,
                              (context, index) {
                                final song = state.songs[index];
                                return ArtistSongItem(
                                    // coverage:ignore-start
                                    onTap: () {},
                                    onOptionsTap: () {},
                                    // coverage:ignore-end
                                    name: song.name,
                                    prefix: (index + 1).toString(),
                                    isVerified: song.verified,
                                    hasVideoLessons: hasInstrumentVideoLesson(state.instrument, song));
                              },
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
                      return CustomScrollView(
                        slivers: [
                          SliverOverlapInjector(
                            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: state.songs.length,
                              (context, index) {
                                final alphabeticalSongs =
                                    state.songs.sortedBy((a) => removeDiacritics(a.name).toLowerCase());
                                final song = alphabeticalSongs[index];
                                return ArtistSongItem(
                                    // coverage:ignore-start
                                    onTap: () {},
                                    onOptionsTap: () {},
                                    // coverage:ignore-end
                                    name: song.name,
                                    prefix: state.prefixes[index],
                                    isVerified: song.verified,
                                    hasVideoLessons: hasInstrumentVideoLesson(state.instrument, song));
                              },
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
                        if (state.videoLessons.isEmpty)
                          const SliverFillRemaining(
                            child: Center(
                              child: ErrorDescriptionWidget(
                                typeError: ErrorDescriptionWidgetType.videoLesson,
                              ),
                            ),
                          )
                        else
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: state.videoLessons.length,
                              (context, index) {
                                final videoLesson = state.videoLessons[index];
                                return ArtistVideoLessonItem(
                                  onTap: () {},
                                  imageUrl: videoLesson.images.small,
                                  artistName: videoLesson.artist?.name ?? "",
                                  title: videoLesson.title,
                                  views: formatVideoLessonView(videoLesson.views, context),
                                  duration: formatVideoLessonDuration(videoLesson.duration),
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

  bool hasInstrumentVideoLesson(Instrument? instrument, ArtistSong song) {
    if (instrument == null && song.videoLessons > 0) {
      return true;
    } else {
      return song.videoLessonsInstruments?.contains(instrument) ?? false;
    }
  }

  String formatVideoLessonView(int views, BuildContext context) {
    return NumberFormat.compact(locale: Localizations.localeOf(context).toLanguageTag()).format(views);
  }

  String formatVideoLessonDuration(int seconds) {
    return DateFormat.ms().format(DateTime.fromMillisecondsSinceEpoch(Duration(seconds: seconds).inMilliseconds));
  }
}
