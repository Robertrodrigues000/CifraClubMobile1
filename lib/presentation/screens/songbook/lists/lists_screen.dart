import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/more/widgets/user_card.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_state.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/special_lists.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/user_lists.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// coverage:ignore-file
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
                  user: null,
                  onLogoutTap: () {},
                  onTap: () {},
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
            UserLists(list: state.userLists)
          ],
        ),
      );
    });
  }
}
