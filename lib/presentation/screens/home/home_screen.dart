import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/home/home_bloc.dart';
import 'package:cifraclub/presentation/screens/home/home_state/home_state.dart';
import 'package:cifraclub/presentation/screens/home/widgets/blog.dart';
import 'package:cifraclub/presentation/screens/home/widgets/highlights/highlights.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_header.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_top_artists.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_top_cifras.dart';
import 'package:cifraclub/presentation/screens/home/widgets/video_lessons.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cifraclub/presentation/screens/home/widgets/profile_bottom_sheet/profile_bottom_sheet.dart';

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
                HomeTopCifras(list: state.topCifras),
                HomeTopArtists(list: state.topArtists),
                HomeVideoLessons(list: state.videoLessons),
                Blog(list: state.blog),
              ]
            ],
          ),
        );
      },
    );
  }
}
