import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/user_card.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/special_lists.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/user_lists.dart';
import 'package:cifraclub/presentation/widgets/thumb_row.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListsScreen extends StatefulWidget {
  const ListsScreen({super.key});

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  late ListsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ListsBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.getLists();
    _bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(builder: (context, state) {
      return Scaffold(
        appBar: CosmosAppBar(
          title: Text(context.text.lists, style: context.typography.title3),
          leading: null,
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
              onTap: () {},
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
            SpecialLists(list: state.specialLists),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
                child: Text(
                  context.text.newlyCreated,
                  style: context.typography.title3,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: ThumbRow.forSpecialList(
                    imagePath: AppSvgs.songbookWillPlayIcon,
                    context: context,
                    backgroundColor: Colors.pink,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: ThumbRow.forCommonList(
                  imageUrls: const [
                    "https://akamai.sscdn.co/letras/108x108/fotos/3/0/8/3/3083b1621a661eee9c2eb4ef9d03daa5-tb.jpg",
                    "https://akamai.sscdn.co/letras/108x108/fotos/e/4/a/7/e4a7eca99c8f6d5c4b7a1ea61dfe2899-tb.jpg",
                    "https://akamai.sscdn.co/letras/108x108/fotos/6/c/4/3/6c43c6533e5ece5e2d539c4804f28f9e-tb.jpg",
                    "", //"https://akamai.sscdn.co/letras/108x108/fotos/e/0/5/3/e053e2dbf6fd2bd607ee173aec4c6361-tb.jpg", // para exibir o placeholder
                    "https://akamai.sscdn.co/letras/108x108/fotos/8/d/b/0/8db0d1ac3efdb1b50400b5b1dba9ab73-tb.jpg",
                  ],
                  placeholder: AppSvgs.artistsAvatarPlaceHolder,
                  context: context,
                ),
              ),
            )),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: ThumbRow.forCommonList(
                  imageUrls: const [
                    "https://akamai.sscdn.co/letras/108x108/fotos/3/0/8/3/3083b1621a661eee9c2eb4ef9d03daa5-tb.jpg",
                    "https://akamai.sscdn.co/letras/108x108/fotos/e/4/a/7/e4a7eca99c8f6d5c4b7a1ea61dfe2899-tb.jpg",
                    "https://akamai.sscdn.co/letras/108x108/fotos/6/c/4/3/6c43c6533e5ece5e2d539c4804f28f9e-tb.jpg",
                    "https://akamai.sscdn.co/letras/108x108/fotos/8/d/b/0/8db0d1ac3efdb1b50400b5b1dba9ab73-tb.jpg",
                  ],
                  placeholder: AppSvgs.artistsAvatarPlaceHolder,
                  context: context,
                ),
              ),
            )),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: ThumbRow.forCommonList(
                  imageUrls: const [
                    "https://akamai.sscdn.co/letras/108x108/fotos/3/0/8/3/3083b1621a661eee9c2eb4ef9d03daa5-tb.jpg",
                    "https://akamai.sscdn.co/letras/108x108/fotos/e/4/a/7/e4a7eca99c8f6d5c4b7a1ea61dfe2899-tb.jpg",
                    "https://akamai.sscdn.co/letras/108x108/fotos/6/c/4/3/6c43c6533e5ece5e2d539c4804f28f9e-tb.jpg",
                  ],
                  placeholder: AppSvgs.artistsAvatarPlaceHolder,
                  context: context,
                ),
              ),
            )),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: ThumbRow.forCommonList(
                  imageUrls: const [
                    "https://akamai.sscdn.co/letras/108x108/fotos/3/0/8/3/3083b1621a661eee9c2eb4ef9d03daa5-tb.jpg",
                    "https://akamai.sscdn.co/letras/108x108/fotos/e/4/a/7/e4a7eca99c8f6d5c4b7a1ea61dfe2899-tb.jpg",
                  ],
                  placeholder: AppSvgs.artistsAvatarPlaceHolder,
                  context: context,
                ),
              ),
            )),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: ThumbRow.forCommonList(
                  imageUrls: const [
                    "https://akamai.sscdn.co/letras/108x108/fotos/3/0/8/3/3083b1621a661eee9c2eb4ef9d03daa5-tb.jpg",
                  ],
                  placeholder: AppSvgs.artistsAvatarPlaceHolder,
                  context: context,
                ),
              ),
            )),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: ThumbRow.forCommonList(
                  imageUrls: const [],
                  placeholder: AppSvgs.artistsAvatarPlaceHolder,
                  context: context,
                ),
              ),
            )),
            SliverToBoxAdapter(
              child: SizedBox.fromSize(size: const Size.fromHeight(20)),
            ),
            UserLists(list: state.userLists)
          ],
        ),
      );
    });
  }
}
