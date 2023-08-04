import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/genres_bottom_sheet/genre_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/artist/artist_entry.dart';
import 'package:cifraclub/presentation/screens/home/home_bloc.dart';
import 'package:cifraclub/presentation/screens/home/home_state.dart';
import 'package:cifraclub/presentation/screens/home/widgets/highlights/highlights.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_button.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_header.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_title.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_top_artists.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_top_songs.dart';
import 'package:cifraclub/presentation/screens/home/widgets/news/blog.dart';
import 'package:cifraclub/presentation/bottom_sheets/profile_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/home/widgets/video_lessons/video_lessons.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_entry.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_entry.dart';
import 'package:cifraclub/presentation/screens/version/version_entry.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cifraclub/presentation/widgets/genres_capsule/genres_capsule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this._genreBottomSheet, {super.key});

  final GenreBottomSheet _genreBottomSheet;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = context.appDimensionScheme;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: HomeHeader(
            user: state.user,
            isPro: state.isPro,
            openLogin: bloc.openLoginPage,
            openProfile: () {
              ProfileBottomSheet(
                user: state.user!,
                onOpenProfile: () => bloc.openProfilePage(),
                onLogout: () => bloc.logoutUser(),
              ).open(context);
            },
            height: dimensions.appBarHeight,
          ),
          body: Builder(
            builder: (context) {
              if (state.error != null) {
                final errorType = state.error is ConnectionError
                    ? ErrorDescriptionWidgetType.connection
                    : ErrorDescriptionWidgetType.server;
                return Center(
                  child: ErrorDescriptionWidget(
                    typeError: errorType,
                    onClick: () => bloc.requestHomeData(genreUrl: state.selectedGenre),
                  ),
                );
              } else {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: dimensions.screenMargin),
                        child: GenresCapsule(
                          genres: state.genres,
                          selectedGenre: state.selectedGenre,
                          onGenreSelected: bloc.onGenreSelected,
                          onMore: () async {
                            final result = await widget._genreBottomSheet.open(context);
                            if (result != null) {
                              bloc.insertGenre(result);
                              return true;
                            }
                            return false;
                          },
                        ),
                      ),
                    ),
                    if (state.isLoading)
                      const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else ...[
                      if (state.highlights != null) Highlights(highlights: state.highlights!),

                      //Songs section
                      HomeTitle(
                        key: const Key("top songs title"),
                        text: context.text.topSongs,
                        horizontalPadding: dimensions.screenMargin,
                        onClick: () => Nav.of(context).push(
                          screenName: TopSongsEntry.name,
                        ),
                      ),
                      HomeTopSongs(
                        topSongs: state.topSongs,
                        onTap: (song) => VersionEntry.pushFromSong(
                          Nav.of(context),
                          song.artist?.url ?? "",
                          song.url,
                          song.artist?.name ?? "",
                          song.name,
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 8)),
                      HomeButton(
                        key: const Key("top songs button"),
                        text: context.text.moreSongs,
                        onTap: () => Nav.of(context).push(
                          screenName: TopSongsEntry.name,
                        ),
                      ),

                      //Artists section
                      HomeTitle(
                        key: const Key("top artists title"),
                        text: context.text.topArtists,
                        horizontalPadding: dimensions.screenMargin,
                        onClick: () => Nav.of(context).push(
                          screenName: TopArtistsEntry.name,
                        ),
                      ),
                      HomeTopArtists(
                        artists: state.topArtists,
                        onTap: (artist) {
                          Nav.of(context)
                              .push(screenName: ArtistEntry.name, params: {'url': artist.url, 'name': artist.name});
                        },
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 8)),
                      HomeButton(
                        key: const Key("top artists button"),
                        text: context.text.moreArtists,
                        onTap: () => Nav.of(context).push(
                          screenName: TopArtistsEntry.name,
                        ),
                      ),

                      //Video lessons section
                      if (state.videoLessons != null) ...[
                        HomeTitle(
                            onClick: state.videoLessons!.length >= 4 ? () {} : null,
                            text: context.text.videos,
                            horizontalPadding: dimensions.screenMargin),
                        VideoLessons(
                          list: state.videoLessons!.take(4).toList(),
                        ),
                        if (state.videoLessons!.length >= 4) ...[
                          const SliverToBoxAdapter(child: SizedBox(height: 8)),
                          HomeButton(
                            key: const Key("video lessons more button"),
                            text: context.text.showMoreButton(context.text.videos.toLowerCase()),
                            onTap: () {},
                          ),
                        ],
                      ],

                      //News Section
                      HomeTitle(
                        text: context.text.homeNews,
                        horizontalPadding: dimensions.screenMargin,
                      ),
                      Blog(
                        list: state.blog,
                        onTap: (news) {},
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 8)),
                      HomeButton(
                        text: context.text.homeMoreNews,
                        onTap: () {},
                      ),
                    ]
                  ],
                );
              }
            },
          ),
        );
      },
    );
  }
}
