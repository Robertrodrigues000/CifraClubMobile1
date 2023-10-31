import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/dialogs/list_limit_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_limit_pro_dialog.dart';
import 'package:cifraclub/presentation/dialogs/save_versions_in_list_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_state.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/count_selected_versions.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/version_limit_card.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/add_version_tile.dart';
import 'package:cifraclub/presentation/widgets/limit_warning.dart';
import 'package:cifraclub/presentation/widgets/loading_indicator_container.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';

class AddVersionsToListScreen extends StatefulWidget {
  const AddVersionsToListScreen({super.key});

  @override
  State<AddVersionsToListScreen> createState() => _AddVersionsToListScreenState();
}

class _AddVersionsToListScreenState extends State<AddVersionsToListScreen> {
  late final AddVersionsToListBloc _bloc = BlocProvider.of<AddVersionsToListBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddVersionsToListBloc, AddVersionsToListState>(
      builder: (context, state) {
        return WillPopScope(
          // coverage:ignore-start
          onWillPop: () async {
            Nav.of(context).pop();
            return true;
          },
          // coverage:ignore-end
          child: Scaffold(
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
                                  // coverage:ignore-start
                                  onTapBackButton: () => Nav.of(context).pop(),
                                  onTapClear: () => _bloc.clearList(),
                                  // coverage:ignore-end
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
                                  bottom: context.appDimensionScheme.bottomPaddingCard,
                                  top: context.appDimensionScheme.topPaddingCard,
                                ),
                                child: VersionLimitCard(
                                  isPro: state.isPro,
                                  height: context.appDimensionScheme.heightLimitCardFree,
                                  isWithinLimit: state.limitState == ListLimitState.withinLimit,
                                  limit: state.versionsLimit,
                                  versionsCount: state.songsCount,
                                  isList: false,
                                  onTap: () {}, // coverage:ignore-line
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    if (state.songs.isEmpty && !state.isHistory)
                      Padding(
                        padding: EdgeInsets.all(context.appDimensionScheme.screenMargin),
                        child: Column(
                          children: [
                            Text(context.text.searchNotFound, style: context.typography.title4),
                            const SizedBox(height: 8),
                            Text(context.text.searchNewTerm, style: context.typography.subtitle7),
                          ],
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.songs.length,
                        itemBuilder: (context, index) {
                          final song = state.songs[index];
                          return AddVersionTile(
                            artist: song.artistName,
                            onTap: () {
                              if (!state.selectedSongs.contains(song)) {
                                if (state.songsCount >= state.versionsLimit) {
                                  showLimitDialog(context);
                                  return;
                                } else {
                                  verifyNextLimitState(context);
                                }
                              }
                              _bloc.addOrRemoveVersion(song);
                            },
                            song: song.songName,
                            state: _bloc.getSongState(song),
                            imageUrl: song.artistImage,
                            trailing: song.isVerified ? SvgPicture.asset(AppSvgs.verifiedIcon) : null,
                          );
                        },
                      ),
                    ),
                    if (state.selectedSongs.isNotEmpty)
                      CountSelectedVersions(
                        versionsCount: state.selectedSongs.length,
                        onClear: () => _bloc.clearCount(),
                        onSave: () async {
                          SaveVersionsInListDialog.show(
                            context: context,
                            bloc: _bloc,
                            totalSongs: state.selectedSongs.length,
                          );
                          await _bloc.addSongsToSongbook().then((params) {
                            SaveVersionsInListDialog.close(context);

                            if (params.songsSaved > 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(context.text.savedListSongs(params.songsSaved))),
                              );
                            }

                            if (params.errorCount > 0 && params.lastSongError != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 3),
                                  content: Text(context.text.errorsListSongs(
                                    params.errorCount,
                                    params.lastSongError!.songName,
                                    params.lastSongError!.artistName,
                                  )),
                                ),
                              );
                            }
                          });
                        },
                      ),
                  ],
                ),
                LoadingIndicatorContainer(
                  isLoading: state.isLoading,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void verifyNextLimitState(
    BuildContext context,
  ) {
    if (_bloc.state.songsCount + 1 == _bloc.state.versionsLimit ||
        _bloc.state.songsCount + 1 == _bloc.state.versionsLimit - _bloc.state.limitThreshold) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        ListLimitWarningSnackBar.getListLimitSnackBar(
          limit: _bloc.state.versionsLimit,
          isVersionLimit: true,
          count: _bloc.state.songsCount,
          listLimitState: _bloc.state.songsCount + 1 == _bloc.state.versionsLimit
              ? ListLimitState.reached
              : ListLimitState.atWarning,
          proLimit: _bloc.state.prolimit,
          isPro: _bloc.state.isPro,
        ),
      );
    }
  }

  void showLimitDialog(BuildContext context) {
    if (_bloc.state.isPro) {
      ListLimitProDialog.show(context: context, isVersionLimit: true, limitCount: _bloc.state.songsCount);
    } else {
      ListLimitDialog.show(context: context, isVersionLimit: true, limitCount: _bloc.state.songsCount);
    }
  }
}
