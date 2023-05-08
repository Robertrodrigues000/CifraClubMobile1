import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'dart:math';

import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/user_card.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/special_lists.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(builder: (context, state) {
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

                Random random = Random();
                _bloc.createNewSongbook("Lista aleatória ${random.nextInt(10000)}");
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
              child: SizedBox.fromSize(size: const Size.fromHeight(20)),
            ),
            UserLists(
              lists: state.userLists,
              onTap: (songbook) {
                _bloc.deleteSongbook(songbook.id);
              },
            )
          ],
        ),
      );
    });
  }
}
