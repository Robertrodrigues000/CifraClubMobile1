import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/home/home_bloc.dart';
import 'package:cifraclub/presentation/screens/home/home_state/home_state.dart';
import 'package:cifraclub/presentation/screens/home/widgets/blog.dart';
import 'package:cifraclub/presentation/screens/home/widgets/highlights/highlights.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_header.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_title.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_top_artists.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_top_cifras.dart';
import 'package:cifraclub/presentation/screens/home/widgets/video_lessons/video_lessons.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_entry.dart';
import 'package:cifraclub/presentation/widgets/buttons/stroked_button.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cifraclub/presentation/screens/home/widgets/profile_bottom_sheet/profile_bottom_sheet.dart';
import 'package:nav/nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: dimensions.screenMargin),
                  child: FilterCapsuleList(
                    capsulePadding: const EdgeInsets.symmetric(horizontal: 8),
                    filters: [
                      if (state.genres.isNotEmpty)
                        ...state.genres
                            .map(
                              (genre) => Filter(
                                  label: genre.name,
                                  onTap: () {
                                    bloc.onGenreSelected(genre.url);
                                  },
                                  isSelected: state.selectedGenre == genre.url),
                            )
                            .toList()
                    ],
                  ),
                ),
              ),
              if (state.isLoading)
                const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.error != null)
                const SliverToBoxAdapter(
                  child: Center(child: Text("Erro")),
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
                    padding: EdgeInsets.only(left: dimensions.screenMargin, right: dimensions.screenMargin, bottom: 32),
                    text: context.text.more_songs,
                    // coverage:ignore-start
                    onClick: () => Nav.of(context).push(
                      screenName: TopSongsEntry.name,
                    ),
                    // coverage:ignore-end
                  ),
                ),
                //Artists section
                HomeTitle(
                  text: context.text.top_artists,
                  horizontalPadding: dimensions.screenMargin,
                ),
                HomeTopArtists(
                  artists: state.topArtists,
                  onTap: (artist) {},
                ),
                SliverToBoxAdapter(
                  child: StrokedButton(
                    padding: EdgeInsets.only(left: dimensions.screenMargin, right: dimensions.screenMargin, bottom: 32),
                    text: context.text.more_artists,
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

                Blog(list: state.blog),
              ]
            ],
          ),
        );
      },
    );
  }
}
