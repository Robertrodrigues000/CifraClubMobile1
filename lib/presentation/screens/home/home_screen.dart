import 'package:cifraclub/presentation/screens/home/home_bloc.dart';
import 'package:cifraclub/presentation/screens/home/home_state.dart';
import 'package:cifraclub/presentation/screens/home/widgets/blog.dart';
import 'package:cifraclub/presentation/screens/home/widgets/highlights.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_top_artists.dart';
import 'package:cifraclub/presentation/screens/home/widgets/home_top_cifras.dart';
import 'package:cifraclub/presentation/screens/home/widgets/video_lessons.dart';
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.requestHomeData();
  }

  @override
  Widget build(BuildContext context) {
    //Bloc
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
          ),
          body: CustomScrollView(
            slivers: [
              // Filtros de gênero
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
