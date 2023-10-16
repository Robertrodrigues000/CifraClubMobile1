import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_list_limit_state.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_user_songbooks.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_user_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_artist_image_preview.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_result.dart';
import 'package:cifraclub/presentation/bottom_sheets/save_version_to_list_bottom_sheet/save_version_to_list_state.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/dialogs/list_limit_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_limit_pro_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/input_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/special_lists.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/user_lists.dart';
import 'package:cifraclub/presentation/widgets/selectable_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveVersionToListBottomSheet {
  final GetAllUserSongbooks _getAllUserSongbooks;
  final InsertUserSongbook _insertUserSongbook;
  final GetListLimitState _getListLimitState;
  final GetVersionsLimitState _getVersionsLimitState;
  final InsertVersionToSongbook _insertVersionToSongbook;
  final ValidateSongbookName _validateSongbookName;
  final GetListLimit _getListLimit;
  final GetVersionsLimit _getVersionsLimit;
  final GetProStatusStream _getProStatusStream;
  final ValidateArtistImagePreview _validateArtistImagePreview;

  SaveVersionToListBottomSheet(
    this._getAllUserSongbooks,
    this._insertUserSongbook,
    this._getListLimitState,
    this._getVersionsLimitState,
    this._insertVersionToSongbook,
    this._validateSongbookName,
    this._getListLimit,
    this._getVersionsLimit,
    this._getProStatusStream,
    this._validateArtistImagePreview,
  );

  // coverage:ignore-start
  Future<void> show({
    required BuildContext context,
    SaveVersionToListBottomSheetBloc? bloc,
    required String artistUrl,
    required String songUrl,
  }) {
    return _show(
      context,
      bloc ??
          SaveVersionToListBottomSheetBloc(
              _getAllUserSongbooks,
              _insertUserSongbook,
              _getListLimitState,
              _getVersionsLimitState,
              _insertVersionToSongbook,
              _validateSongbookName,
              _getListLimit,
              _getVersionsLimit,
              _getProStatusStream,
              _validateArtistImagePreview,
              artistUrl,
              songUrl)
        ..init(),
    );
  }
  // coverage:ignore-end

  Future<void> _show(
    BuildContext screenContext,
    SaveVersionToListBottomSheetBloc bloc,
  ) {
    final controller = ScrollController();

    return DefaultBottomSheet.showBottomSheet<SaveToListResult>(
        child: BlocProvider(
          create: (_) => bloc,
          child: BlocBuilder<SaveVersionToListBottomSheetBloc, SaveVersionToListState>(
            builder: (context, state) {
              return Material(
                child: CustomScrollView(
                  controller: controller,
                  shrinkWrap: true,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
                        child: Text(
                          context.text.saveVersionToList,
                          style: context.typography.title3,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SelectableItem(
                        key: const Key("create-new-list"),
                        isSelected: false,
                        onTap: () {
                          DefaultBottomSheet.close(context);
                          if (state.listState != ListLimitState.reached) {
                            InputDialog.show(
                              context: context,
                              isNewList: true,
                              onSave: (widgetContext, name) async {
                                final isValidInput = await bloc.isValidSongbookName(name);
                                switch (isValidInput) {
                                  case true:
                                    if (widgetContext.mounted) {
                                      InputDialog.close(widgetContext);
                                    }
                                    final result = await bloc.createNewSongbook(name);

                                    if (screenContext.mounted) {
                                      handleResult(screenContext, result, state.isPro);
                                    }
                                    break;
                                  case false:
                                    if (widgetContext.mounted) {
                                      ScaffoldMessenger.of(widgetContext)
                                          .showSnackBar(SnackBar(content: Text(widgetContext.text.listUsedName)));
                                    }
                                    break;
                                }
                              },
                            );
                          } else {
                            handleResult(screenContext,
                                VersionListLimitStateReached(versionsLimit: bloc.getListLimit()), state.isPro);
                          }
                        },
                        icon: AppSvgs.newSongbookIcon,
                        text: context.text.createNewList,
                      ),
                    ),
                    SpecialLists(
                        lists: state.specialLists,
                        onTap: (songbook) async {
                          DefaultBottomSheet.close(context);
                          final result = await bloc.addSongToSongbook(
                            songbookId: songbook.id,
                            name: ListType.getListTitle(context, songbook),
                          );

                          if (screenContext.mounted) {
                            handleResult(screenContext, result, state.isPro);
                          }
                        }),
                    if (state.userLists.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Divider(
                            thickness: 1,
                            color: context.colors.neutralTertiary,
                          ),
                        ),
                      ),
                    UserLists(
                      lists: state.userLists,
                      onTap: (songbook) async {
                        DefaultBottomSheet.close(context);
                        final result = await bloc.addSongToSongbook(songbookId: songbook.id, name: songbook.name);

                        if (screenContext.mounted) {
                          handleResult(screenContext, result, state.isPro);
                        }
                      },
                      validatePreview: (preview) => bloc.validatePreview(preview),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        context: screenContext,
        scrollController: controller);
  }

  void handleResult(BuildContext context, SaveToListResult result, bool isPro) {
    switch (result) {
      case VersionListLimitStateReached():
        isPro
            ? ListLimitProDialog.show(context: context, isVersionLimit: true, limitCount: result.versionsLimit)
            : ListLimitDialog.show(context: context, isVersionLimit: true, limitCount: result.versionsLimit);
      case SaveVersionToListCompleted():
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(context.text.saveVersionToListMessage(result.name))));
          _showLimitWarningSnackBar(context, result.listLimitState, isPro, result.versionLimitState);
        }
      case SaveToListError():
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.text.errorListSong)));
          _showLimitWarningSnackBar(context, result.listLimitState, isPro);
        }
    }
  }

  void _showLimitWarningSnackBar(
    BuildContext context,
    ListLimitState? listLimitState,
    bool isPro, [
    ListLimitState? versionLimitState,
  ]) {
    if (versionLimitState == ListLimitState.atWarning && !isPro) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.text.listLimitTitle)));
    } else if (listLimitState == ListLimitState.atWarning && !isPro) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.text.listLimitProDescription1)));
    }
  }
}
