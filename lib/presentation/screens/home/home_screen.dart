import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/home/home_bloc.dart';
import 'package:cifraclub/presentation/screens/home/home_state/home_state.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_title.dart';
import 'package:cifraclub/presentation/screens/home/widgets/news/blog.dart';
import 'package:cifraclub/presentation/screens/home/widgets/highlights/highlights.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_header.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_top_artists.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_top_cifras.dart';
import 'package:cifraclub/presentation/screens/home/widgets/video_lessons/video_lessons.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_entry.dart';
import 'package:cifraclub/presentation/widgets/buttons/stroked_button.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cifraclub/presentation/widgets/genres_bottom_sheet/genre_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/genres_capsule/genres_capsule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cifraclub/presentation/screens/home/widgets/profile_bottom_sheet/profile_bottom_sheet.dart';
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
    bloc.initGenres();
    bloc.getUserInfo();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.requestHomeData();
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
                onOpenMyLists: () {}, // TODO: verificar se vai permanecer esse icone, caso sim implementar a navegação
                onLogout: () => bloc.logoutUser(),
              ).open(context);
            },
            height: dimensions.appBarHeight,
          ),
          body: state.error is ConnectionError
              ? const Center(child: ErrorDescriptionWidget(ErrorDescriptionWidgetType.connection))
              : CustomScrollView(
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
                    else if (state.error is ServerError)
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: ErrorDescriptionWidget(ErrorDescriptionWidgetType.server),
                      )
                    else ...[
                      Highlights(highlights: state.highlights),
                      //Cifras section
                      HomeTitle(
                        text: context.text.topSongs,
                        horizontalPadding: dimensions.screenMargin,
                        // coverage:ignore-start
                        onClick: () => Nav.of(context).push(
                          screenName: TopSongsEntry.name,
                        ),
                        // coverage:ignore-end
                      ),
                      HomeTopCifras(
                        topSongs: state.topCifras,
                        onTap: (song) {},
                      ),
                      SliverToBoxAdapter(
                        child: StrokedButton(
                          padding: EdgeInsets.only(
                              left: dimensions.screenMargin, right: dimensions.screenMargin, bottom: 32),
                          text: context.text.moreSongs,
                          // coverage:ignore-start
                          onClick: () => Nav.of(context).push(
                            screenName: TopSongsEntry.name,
                          ),
                          // coverage:ignore-end
                        ),
                      ),
                      //Artists section
                      HomeTitle(
                        text: context.text.topArtists,
                        horizontalPadding: dimensions.screenMargin,
                      ),
                      HomeTopArtists(
                        artists: state.topArtists,
                        onTap: (artist) {},
                      ),
                      SliverToBoxAdapter(
                        child: StrokedButton(
                          padding: EdgeInsets.only(
                              left: dimensions.screenMargin, right: dimensions.screenMargin, bottom: 32),
                          text: context.text.moreArtists,
                          onClick: () {},
                        ),
                      ),
                      //Videolessons section

                      HomeTitle(
                          onClick: state.videoLessons.length >= 4 ? () {} : null,
                          text: context.text.videos,
                          horizontalPadding: dimensions.screenMargin),
                      VideoLessons(
                        list: state.videoLessons.take(4).toList(),
                      ),
                      if (state.videoLessons.length >= 4)
                        SliverToBoxAdapter(
                            key: const Key("videolessons more button"),
                            child: StrokedButton(
                                padding: EdgeInsets.only(
                                  left: dimensions.screenMargin,
                                  right: dimensions.screenMargin,
                                  bottom: 32,
                                ),
                                text: context.text.showMoreButton(context.text.videos.toLowerCase()),
                                onClick: () {})),

                      HomeTitle(
                        text: context.text.homeNews,
                        horizontalPadding: dimensions.screenMargin,
                      ),
                      Blog(
                        list: state.blog,
                        onTap: (news) {},
                      ),
                      SliverToBoxAdapter(
                        child: StrokedButton(
                            padding: EdgeInsets.only(
                              left: dimensions.screenMargin,
                              right: dimensions.screenMargin,
                              bottom: 32,
                            ),
                            text: context.text.homeMoreNews,
                            onClick: () {}),
                      ),
                    ]
                  ],
                ),
        );
      },
    );
  }
}
