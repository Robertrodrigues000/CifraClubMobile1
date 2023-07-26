// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/search/search_bloc.dart';
import 'package:cifraclub/presentation/screens/search/search_state.dart';
import 'package:cifraclub/presentation/screens/search/widgets/search_app_bar.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/add_version_tile.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/song_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: SearchAppBar(
            topSafeArea: MediaQuery.of(context).viewPadding.top,
            searchInputHeight: context.appDimensionScheme.searchInputHeight,
          ),
          body: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.versions.length,
                  (context, index) {
                    final version = state.versions[index];
                    return AddVersionTile(
                      artist: version.artist.name,
                      onTap: () {},
                      song: version.name,
                      state: SongState.toAdd,
                      imageUrl: version.artist.image?.size162,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
