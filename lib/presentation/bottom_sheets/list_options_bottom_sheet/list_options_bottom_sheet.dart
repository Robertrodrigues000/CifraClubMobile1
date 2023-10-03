import 'package:cifraclub/domain/app/use_cases/share_link.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/clear_versions_from_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/update_songbook_data.dart';
import 'package:cifraclub/domain/songbook/use_cases/validate_songbook_name.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet/list_options_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/privacy_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/clear_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/delete_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/input_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen_builder.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typed_result/typed_result.dart';

class ListOptionsBottomSheet {
  final DeleteSongbook _deleteSongbook;
  final UpdateSongbookData _updateSongbookData;
  final ValidateSongbookName _validateSongbookName;
  final ClearVersionsFromSongbook _clearSongsFromSongbook;
  final ShareLink _shareLink;
  final EditListScreenBuilder _editListScreenBuilder;

  const ListOptionsBottomSheet(
    this._clearSongsFromSongbook,
    this._deleteSongbook,
    this._shareLink,
    this._updateSongbookData,
    this._validateSongbookName,
    this._editListScreenBuilder,
  );

  // coverage:ignore-start
  Future<void> open({
    required BuildContext context,
    required bool isUserList,
    required int? ccid,
    required Songbook songbook,
    required VoidCallback onDeleteSongbook,
    bool haveEditMode = false,
    ListOptionsBottomSheetBloc? bloc,
  }) {
    return _show(
      context,
      bloc ??
          ListOptionsBottomSheetBloc(
            _deleteSongbook,
            _updateSongbookData,
            _validateSongbookName,
            _clearSongsFromSongbook,
            _shareLink,
          ),
      isUserList,
      ccid,
      onDeleteSongbook,
      songbook,
      haveEditMode,
    );
  }
  // coverage:ignore-end

  Future<void> _show(
    BuildContext context,
    ListOptionsBottomSheetBloc bloc,
    bool isUserList,
    int? ccid,
    VoidCallback onDeleteSongbook,
    Songbook songbook,
    bool haveEditMode,
  ) {
    final controller = ScrollController();

    final options = List<ListOptionsBottomSheetItem>.from(ListOptionsBottomSheetItem.values);
    if (songbook.id == null || ccid == null || !songbook.isPublic) {
      options.removeWhere((element) => element == ListOptionsBottomSheetItem.share);
    }
    if (!haveEditMode) {
      options.removeWhere((element) => element == ListOptionsBottomSheetItem.edit);
    }

    return DefaultBottomSheet.showBottomSheet(
      child: BlocProvider(
        create: (_) => bloc,
        child: BlocBuilder<ListOptionsBottomSheetBloc, dynamic>(
          builder: (_, __) {
            return SingleChildScrollView(
              controller: controller,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
                    child: Text(
                      context.text.listOptions,
                      style: context.typography.title3,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (isUserList)
                    ...options.map(
                      (e) {
                        return IconTextTile(
                          onClick: () async {
                            switch (e) {
                              case ListOptionsBottomSheetItem.clear:
                                DefaultBottomSheet.close(context);
                                final clearDialog = await ClearDialog.show(context);
                                if (clearDialog) {
                                  await bloc.clearList(songbook.id);
                                }
                                break;
                              case ListOptionsBottomSheetItem.delete:
                                DefaultBottomSheet.close(context);
                                final result = await DeleteDialog.show(context);
                                if (result) {
                                  await bloc.deleteSongbook(songbook.id).then((value) {
                                    if (value) {
                                      onDeleteSongbook();
                                    }
                                  });
                                }
                                break;
                              case ListOptionsBottomSheetItem.edit:
                                DefaultBottomSheet.close(context);
                                await _editListScreenBuilder.push(context, songbook.name, songbook.id ?? 0);
                                break;
                              case ListOptionsBottomSheetItem.rename:
                                DefaultBottomSheet.close(context);
                                InputDialog.show(
                                  context: context,
                                  isNewList: false,
                                  listName: songbook.name,
                                  onSave: (widgetContext, newName) async {
                                    final isValidInput = await bloc.isValidSongbookName(newName);

                                    switch (isValidInput) {
                                      case true:
                                        (await bloc.updateSongbookData(songbook: songbook, songbookName: newName)).when(
                                          success: (_) {
                                            InputDialog.close(context);
                                          },
                                          failure: (_) {
                                            ScaffoldMessenger.of(widgetContext).showSnackBar(
                                              SnackBar(content: Text(context.text.listServerError)),
                                            );
                                          },
                                        );
                                        break;
                                      case false:
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(widgetContext).showSnackBar(
                                            SnackBar(content: Text(context.text.listUsedName)),
                                          );
                                        }
                                        break;
                                    }
                                  },
                                );
                                break;
                              case ListOptionsBottomSheetItem.share:
                                final box = context.findRenderObject() as RenderBox?;
                                final rect = box != null ? box.localToGlobal(Offset.zero) & box.size : null;
                                final link = AppUrls.songbookUrlFormat(ccid!, songbook.id!);
                                DefaultBottomSheet.close(context);
                                await bloc.shareLink(link, rect);
                                break;
                              case ListOptionsBottomSheetItem.privacy:
                                DefaultBottomSheet.close(context);
                                PrivacyBottomSheet(
                                  isPublic: songbook.isPublic,
                                  onTap: (privacy) async {
                                    await bloc.updateSongbookData(songbook: songbook, isPublic: privacy);
                                  },
                                ).show(context);
                                break;
                            }
                          },
                          text: e.getText(context),
                          leadingIconAsset: e.icon,
                        );
                      },
                    )
                  else
                    IconTextTile(
                      onClick: () async {
                        DefaultBottomSheet.close(context);
                        final clearDialog = await ClearDialog.show(context);
                        if (clearDialog) {
                          await bloc.clearList(songbook.id);
                        }
                      },
                      text: ListOptionsBottomSheetItem.clear.getText(context),
                      leadingIconAsset: ListOptionsBottomSheetItem.clear.icon,
                    ),
                  const SizedBox(height: 16)
                ],
              ),
            );
          },
        ),
      ),
      context: context,
      scrollController: controller,
    );
  }
}

enum ListOptionsBottomSheetItem {
  share(AppSvgs.shareIcon),
  rename(AppSvgs.musicalStylesIcon),
  edit(AppSvgs.editIcon),
  clear(AppSvgs.clearIcon),
  delete(AppSvgs.deleteIcon),
  privacy(AppSvgs.privacyIcon);

  final String icon;

  const ListOptionsBottomSheetItem(this.icon);

  String getText(BuildContext context) {
    switch (this) {
      case ListOptionsBottomSheetItem.share:
        return context.text.share;
      case ListOptionsBottomSheetItem.rename:
        return context.text.renameList;
      case ListOptionsBottomSheetItem.edit:
        return context.text.editTabsList;
      case ListOptionsBottomSheetItem.clear:
        return context.text.clearList;
      case ListOptionsBottomSheetItem.delete:
        return context.text.deleteList;
      case ListOptionsBottomSheetItem.privacy:
        return context.text.privacyList;
    }
  }
}
