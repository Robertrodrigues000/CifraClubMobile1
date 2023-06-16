import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/add_cifras_to_list_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/bottom_sheet/list_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/songbook/bottom_sheet/privacy_bottom_sheet.dart';
import 'package:cifraclub/presentation/dialogs/logout_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_limit_card.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_operation_dialogs/clear_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_operation_dialogs/delete_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_operation_dialogs/input_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/special_lists.dart';
import 'package:cifraclub/presentation/widgets/user_card.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/user_lists.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';
import 'package:typed_result/typed_result.dart';

class ListsScreen extends StatefulWidget {
  const ListsScreen({super.key, required this.onTapSongbook});

  final Function(Songbook) onTapSongbook;

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  late ListsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ListsBloc>(context);
    _bloc.initListLimitStreams();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.init();
    _bloc.initListLimitStreams();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CosmosAppBar(
            toolbarHeight: context.appDimensionScheme.appBarHeight,
            title: Text(context.text.lists, style: context.typography.title3),
            leading: null,
            automaticallyImplyLeading: false,
            actions: [
              InkWell(
                onTap: () {
                  InputDialog.show(
                    context: context,
                    isNewList: true,
                    onSave: (widgetContext, name) async {
                      final isValidInput = await _bloc.isValidSongbookName(name);

                      switch (isValidInput) {
                        case true:
                          (await _bloc.createNewSongbook(name)).when(
                            success: (songbook) {
                              InputDialog.close(context);
                              Nav.of(context).push(
                                screenName: AddCifrasToListEntry.name,
                                params: AddCifrasToListEntry.declareParams(songbook.id!),
                              );
                            },
                            failure: (_) {
                              ScaffoldMessenger.of(widgetContext)
                                  .showSnackBar(SnackBar(content: Text(context.text.listServerError)));
                            },
                          );
                          break;
                        case false:
                          if (context.mounted) {
                            ScaffoldMessenger.of(widgetContext)
                                .showSnackBar(SnackBar(content: Text(context.text.listUsedName)));
                          }
                          break;
                      }
                    },
                  );
                },
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: SvgPicture.asset(
                    AppSvgs.addIcon,
                    fit: BoxFit.none,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
              SizedBox(width: context.appDimensionScheme.appBarMargin),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: context.appDimensionScheme.screenMargin,
                    right: context.appDimensionScheme.screenMargin,
                    bottom: 16,
                  ),
                  child: UserCard(
                    user: state.user,
                    onLogoutTap: () async {
                      await LogoutDialog.show(
                        context: context,
                        onLogout: _bloc.logout,
                      );
                    },
                    onTap: () => state.user == null ? _bloc.openLoginPage() : _bloc.openUserProfilePage(),
                    onSync: _bloc.syncList,
                    isSyncing: state.isSyncing,
                  ),
                ),
              ),
              SpecialLists(lists: state.specialLists),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: context.appDimensionScheme.screenMargin,
                      right: context.appDimensionScheme.screenMargin,
                      top: 36),
                  child: Text(
                    context.text.newlyCreated,
                    style: context.typography.title3,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListLimitCard(
                    listCount: state.listCount,
                    limit: state.listLimit,
                    isPro: state.isPro,
                    isWithinLimit: state.listState == ListLimitState.withinLimit,
                    // coverage:ignore-start
                    onTap: () {},
                    // coverage:ignore-end
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox.fromSize(size: const Size.fromHeight(20)),
              ),
              UserLists(
                lists: state.userLists,
                onTap: (songbook) {
                  widget.onTapSongbook(songbook);
                },
                onOptionsTap: (songbook) {
                  ListOptionsBottomSheet(
                    ccid: state.user?.id,
                    songbookId: songbook.id,
                    isPublic: songbook.isPublic,
                    isUserList: true,
                    onTap: (options, [rect]) async {
                      switch (options) {
                        case ListOptionsBottomSheetItem.clear:
                          final clearDialog = await ClearDialog.show(context);
                          if (clearDialog) {
                            _bloc.clearList(songbook.id);
                          }
                          break;
                        case ListOptionsBottomSheetItem.delete:
                          final result = await DeleteDialog.show(context);
                          if (result) {
                            await _bloc.deleteSongbook(songbook.id);
                          }
                          break;
                        case ListOptionsBottomSheetItem.rename:
                          InputDialog.show(
                            context: context,
                            isNewList: false,
                            listName: songbook.name,
                            onSave: (widgetContext, newName) async {
                              final isValidInput = await _bloc.isValidSongbookName(newName);

                              switch (isValidInput) {
                                case true:
                                  (await _bloc.updateSongbookData(songbook: songbook, songbookName: newName)).when(
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
                        // coverage:ignore-start
                        case ListOptionsBottomSheetItem.privacy:
                          PrivacyBottomSheet(
                            isPublic: false,
                            onTap: (privacy) {
                              switch (privacy) {
                                case true:
                                  // ignore: avoid_print
                                  print("public");
                                  break;
                                case false:
                                  // ignore: avoid_print
                                  print("private");
                                  break;
                              }
                            },
                          ).show(context);
                          break;
                        case ListOptionsBottomSheetItem.share:
                          final link = AppUrls.cifraListUrlFormat(state.user!.id!, songbook.id!);
                          _bloc.shareLink(link, rect);
                          break;
                        // coverage:ignore-end
                      }
                    },
                  ).show(context);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
