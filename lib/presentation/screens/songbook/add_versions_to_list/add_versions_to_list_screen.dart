import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_state.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/count_selected_versions.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/version_limit_card.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/add_version_tile.dart';
import 'package:cifraclub/presentation/widgets/loading_indicator_container.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class AddVersionsToListScreen extends StatefulWidget {
  const AddVersionsToListScreen({super.key});

  @override
  State<AddVersionsToListScreen> createState() => _AddVersionsToListScreenState();
}

class _AddVersionsToListScreenState extends State<AddVersionsToListScreen> {
  late AddVersionsToListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AddVersionsToListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVersionsToListBloc, AddVersionsToListState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  ScrolledUnderBuilder(
                    builder: (context, isScrolledUnder) {
                      return Container(
                        color: isScrolledUnder ? context.colors.neutralSecondary : context.colors.neutralPrimary,
                        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.appDimensionScheme.screenMargin,
                              ),
                              height: context.appDimensionScheme.searchInputHeight,
                              child: CosmosSearchBar(
                                onChanged: (query) => _bloc.searchSongs(query),
                                onTapBackButton: () => Nav.of(context).pop(),
                                onTapClear: () => _bloc.clearList(),
                                invertColorsOnScroll: true,
                                cancelText: context.text.cancel,
                                hintText: context.text.searchSongs,
                                labelText: context.text.searchSongs,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: context.appDimensionScheme.screenMargin,
                                right: context.appDimensionScheme.screenMargin,
                                bottom: context.appDimensionScheme.bottomPaddingCounter,
                                top: context.appDimensionScheme.topPaddingCounter,
                              ),
                              child: VersionLimitCard(
                                isPro: state.isPro,
                                isWithinLimit: state.limitState == ListLimitState.withinLimit,
                                limit: state.versionsLimit,
                                versionsCount: state.versionsCount,
                                onTap: () {}, // coverage:ignore-line
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.songs.length,
                      itemBuilder: (context, index) {
                        final song = state.songs[index];
                        return AddVersionTile(
                          artist: song.artistName,
                          onTap: () => _bloc.addOrRemoveVersion(song),
                          song: song.songName,
                          state: _bloc.getSongState(song),
                          imageUrl: song.artistImage,
                        );
                      },
                    ),
                  ),
                  if (state.selectedVersions.isNotEmpty)
                    CountSelectedVersions(
                      versionsCount: state.selectedVersions.length,
                      onClear: () => _bloc.clearCount(),
                      onSave: () {}, // coverage:ignore-line
                    ),
                ],
              ),
              LoadingIndicatorContainer(
                isLoading: state.isLoading,
              ),
            ],
          ),
        );
      },
    );
  }
}