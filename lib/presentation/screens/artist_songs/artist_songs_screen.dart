// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_state.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_video_lesson_item.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_songs_fixed_header.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_songs_collapsed_header.dart';
import 'package:cosmos/cosmos.dart';
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

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ArtistSongsBloc>(context);
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    scrollController.addListener(_onScroll);
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
                              childCount: 200,
                              (context, index) {
                                return Text("${context.text.mostAccessed} $index");
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
                              childCount: 200,
                              (context, index) {
                                return Text("${context.text.alphabeticalOrder} $index");
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

  String formatVideoLessonView(int views, BuildContext context) {
    return NumberFormat.compact(locale: Localizations.localeOf(context).toLanguageTag()).format(views);
  }

  String formatVideoLessonDuration(int seconds) {
    return DateFormat.ms().format(DateTime.fromMillisecondsSinceEpoch(Duration(seconds: seconds).inMilliseconds));
  }
}
