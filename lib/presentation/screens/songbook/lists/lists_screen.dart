import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/dialogs/logout_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/input_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_limit_card.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/special_lists.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
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
  const ListsScreen({
    super.key,
    required this.onTapSongbook,
    this.selectedSongbookId,
    required this.listOptionsBottomSheet,
    required this.isTablet,
  });

  final ListOptionsBottomSheet listOptionsBottomSheet;
  final Function(Songbook) onTapSongbook;
  final int? selectedSongbookId;
  final bool isTablet;

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  late final ListsBloc _bloc = BlocProvider.of<ListsBloc>(context);

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
                onTap: () => _createSongbook(context, _bloc),
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
              SpecialLists(
                lists: state.specialLists,
                selectedSongbookId: widget.selectedSongbookId,
                onTap: widget.onTapSongbook,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: context.appDimensionScheme.screenMargin,
                    right: context.appDimensionScheme.screenMargin,
                    top: 36,
                  ),
                  child: Text(
                    context.text.newlyCreated,
                    style: context.typography.title3,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: state.isPro ? 8 : 16,
                      left: context.appDimensionScheme.screenMargin,
                      right: context.appDimensionScheme.screenMargin,
                      bottom: context.appDimensionScheme.screenMargin),
                  child: ListLimitCard(
                    listCount: state.listCount,
                    limit: state.listLimit,
                    isPro: state.isPro,
                    isWithinLimit: state.listState == ListLimitState.withinLimit,
                    onTap: () {}, // coverage:ignore-line
                  ),
                ),
              ),
              if (state.listCount == 0)
                SliverToBoxAdapter(
                  child: CifraClubButton(
                    type: ButtonType.outline,
                    onPressed: () => _createSongbook(context, _bloc),
                    padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
                    child: Text(context.text.createListButtonText),
                  ),
                ),
              UserLists(
                lists: state.userLists,
                selectedSongbookId: widget.selectedSongbookId,
                onTap: (songbook) {
                  widget.onTapSongbook(songbook);
                },
                onOptionsTap: (songbook) async {
                  await widget.listOptionsBottomSheet.open(
                    context: context,
                    isUserList: true,
                    ccid: state.user?.id,
                    songbook: songbook,
                    onDeleteSongbook: () {
                      if (widget.isTablet && widget.selectedSongbookId == songbook.id) {
                        widget.onTapSongbook(state.specialLists.first);
                      }
                    },
                  );
                },
                validatePreview: (preview) => _bloc.validatePreview(preview),
              ),
            ],
          ),
        );
      },
    );
  }
}

void _createSongbook(
  BuildContext context,
  ListsBloc bloc,
) {
  InputDialog.show(
    context: context,
    isNewList: true,
    onSave: (widgetContext, name) async {
      final isValidInput = await bloc.isValidSongbookName(name);

      switch (isValidInput) {
        case true:
          (await bloc.createNewSongbook(name)).when(
            success: (songbook) {
              InputDialog.close(context);
              AddVersionsToListEntry.push(Nav.of(context), songbook.id!);
            },
            failure: (_) {
              ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBar(content: Text(context.text.listServerError)));
            },
          );
          break;
        case false:
          if (context.mounted) {
            ScaffoldMessenger.of(widgetContext).showSnackBar(SnackBar(content: Text(context.text.listUsedName)));
          }
          break;
      }
    },
  );
}
