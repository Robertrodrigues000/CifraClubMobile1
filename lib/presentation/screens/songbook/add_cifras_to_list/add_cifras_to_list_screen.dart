import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/add_cifras_to_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/add_cifras_to_list_state.dart';
import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/widgets/count_selected_tabs.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/cifra_limit_card.dart';
import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/widgets/add_cifra_tile/add_cifra_tile.dart';
import 'package:cifraclub/presentation/widgets/loading_indicator_container.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class AddCifrasToListScreen extends StatefulWidget {
  const AddCifrasToListScreen({super.key});

  @override
  State<AddCifrasToListScreen> createState() => _AddCifrasToListScreenState();
}

class _AddCifrasToListScreenState extends State<AddCifrasToListScreen> {
  late AddCifrasToListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AddCifrasToListBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCifrasToListBloc, AddCifrasToListState>(
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
                              child: CifraLimitCard(
                                isPro: state.isPro,
                                isWithinLimit: state.limitState == ListLimitState.withinLimit,
                                limit: state.tabsLimit,
                                tabsCount: state.tabsCount,
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
                        return AddCifraTile(
                          artist: song.artistName,
                          onTap: () => _bloc.addOrRemoveCifra(song),
                          song: song.songName,
                          state: _bloc.getSongState(song),
                          imageUrl: song.artistImage,
                        );
                      },
                    ),
                  ),
                  if (state.selectedCifras.isNotEmpty)
                    CountSelectedTabs(
                      tabsCount: state.selectedCifras.length,
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
