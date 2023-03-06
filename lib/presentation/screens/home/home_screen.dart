// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/home/home_bloc.dart';
import 'package:cifraclub/presentation/screens/home/home_state.dart';
import 'package:cifraclub/presentation/screens/home/widgets/blog.dart';
import 'package:cifraclub/presentation/screens/home/widgets/highlights.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_header.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_top_artists.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_top_cifras.dart';
import 'package:cifraclub/presentation/screens/home/widgets/video_lessons.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    bloc.getUserInfo();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.requestHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: HomeHeader(
            user: state.user,
            isPro: state.isPro,
            openLogin: bloc.openLoginPage,
            openProfile: bloc.openProfilePage,
            height: context.appDimensionScheme.appBarHeight,
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: FilterCapsuleList(
                  capsulePadding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                  filters: [
                    if (state is HomeLoadedState)
                      ...state.genres
                          .map(
                            (genre) => Filter(
                                label: genre,
                                onTap: () {
                                  bloc.onGenreSelected(genre);
                                },
                                isSelected: state.selectedGenre == genre),
                          )
                          .toList()
                  ],
                ),
              ),
              if (state is HomeLoadingState)
                const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
              if (state is HomeLoadedState) ...[
                Highlights(
                  list: state.highlights,
                ),
                HomeTopCifras(
                  list: state.topCifras,
                ),
                HomeTopArtists(
                  list: state.topArtists,
                ),
                VideoLessons(
                  list: state.videoLessons,
                ),
                Blog(
                  list: state.blog,
                ),
              ] else if (state is HomeErrorState)
                const SliverToBoxAdapter(
                  child: Text("Erro"),
                )
            ],
          ),
        );
      },
    );
  }
}
