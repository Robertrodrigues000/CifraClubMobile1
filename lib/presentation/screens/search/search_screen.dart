import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/search/search_bloc.dart';
import 'package:cifraclub/presentation/screens/search/search_state.dart';
import 'package:cifraclub/presentation/screens/search/widgets/search_app_bar.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/add_version_tile.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/song_state.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchBloc _bloc = BlocProvider.of<SearchBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: SearchAppBar(
            topSafeArea: MediaQuery.of(context).viewPadding.top,
            searchInputHeight: context.appDimensionScheme.searchInputHeight,
            onChanged: _bloc.search,
            onTapClear: _bloc.clearList,
            hintText: context.text.searchHint,
          ),
          body: CustomScrollView(
            slivers: [
              if (state.error != null)
                SliverFillRemaining(
                  child: Center(
                    child: ErrorDescriptionWidget(
                      typeError: state.error! is ConnectionError
                          ? ErrorDescriptionWidgetType.connection
                          : ErrorDescriptionWidgetType.server,
                      onClick: () {}, // coverage:ignore-line
                    ),
                  ),
                )
              else if (state.result.isEmpty && !state.shouldShowRecent)
                SliverFillRemaining(
                  child: Center(
                    child: ErrorDescriptionWidget(
                      typeError: ErrorDescriptionWidgetType.searchResultNotFound,
                      onClick: () {}, // coverage:ignore-line
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.recent.length,
                    (context, index) {
                      final version = state.recent[index];
                      return AddVersionTile(
                        artist: version.artist.name,
                        onTap: () {}, // coverage:ignore-line
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
