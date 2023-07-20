// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_state.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/artist_songs/widgets/artist_video_lesson_item.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ArtistSongsScreen extends StatefulWidget {
  const ArtistSongsScreen({super.key});

  @override
  State<ArtistSongsScreen> createState() => _ArtistSongsScreenState();
}

class _ArtistSongsScreenState extends State<ArtistSongsScreen> with SingleTickerProviderStateMixin {
  late ArtistSongsBloc _bloc;
  final PageController pageController = PageController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ArtistSongsBloc>(context);
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistSongsBloc, ArtistSongsState>(
      bloc: _bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: CosmosAppBar(
            title: Text(
              context.text.songs(200),
              style: context.typography.title4.copyWith(color: context.colors.textPrimary),
            ),
          ),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(state.artistName),
                      ),
                      TabBar(
                        controller: _tabController,
                        labelPadding: const EdgeInsets.symmetric(vertical: 15),
                        indicatorWeight: 3,
                        onTap: pageController.jumpToPage,
                        splashFactory: NoSplash.splashFactory,
                        overlayColor: MaterialStateProperty.resolveWith((_) => Colors.transparent),
                        tabs: [
                          Text(
                            context.text.mostAccessed,
                            style: context.typography.subtitle4,
                          ),
                          Text(
                            context.text.alphabeticalOrder,
                            style: context.typography.subtitle4,
                          ),
                          Text(
                            context.text.videoLessons,
                            style: context.typography.subtitle4,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: Builder(builder: (context) {
              return PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: <Widget>[
                  CustomScrollView(slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: 200,
                        (context, index) {
                          return Text("${context.text.mostAccessed} $index");
                        },
                      ),
                    ),
                  ]),
                  CustomScrollView(slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: 200,
                        (context, index) {
                          return Text("${context.text.alphabeticalOrder} $index");
                        },
                      ),
                    ),
                  ]),
                  CustomScrollView(slivers: [
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
                  ]),
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
