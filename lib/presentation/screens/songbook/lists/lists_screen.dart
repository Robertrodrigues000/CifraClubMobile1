import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';

import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_limit_card.dart';
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
    return BlocListener<ListsBloc, ListsState>(
      listener: (context, state) {
        if (state.isError == true) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Rename Error")));
        }
      },
      child: BlocBuilder<ListsBloc, ListsState>(builder: (context, state) {
        return Scaffold(
          appBar: CosmosAppBar(
            toolbarHeight: context.appDimensionScheme.appBarHeight,
            title: Text(context.text.lists, style: context.typography.title3),
            leading: null,
            automaticallyImplyLeading: false,
            actions: [
              InkWell(
                // Por enquanto esse click é para testar
                // coverage:ignore-start
                onTap: () {
                  widget.onTapSongbook(
                    Songbook(
                      name: "Segundo",
                      isPublic: true,
                      createdAt: DateTime.now(),
                      totalSongs: 12,
                      type: ListType.cantPlay,
                    ),
                  );

                  InputDialog.show(
                    context: context,
                    isNewList: true,
                    onTap: (name) {
                      _bloc.createNewSongbook(name);
                    },
                  );
                },
                // coverage:ignore-end
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
                    onLogoutTap: _bloc.logout,
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
                  //_bloc.deleteSongbook(songbook.id);
                  InputDialog.show(
                    context: context,
                    isNewList: false,
                    listName: songbook.name,
                    onTap: (newName) {
                      _bloc.updateSongbookData(songbook: songbook, songbookName: newName);
                    },
                  );
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
