import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/dialogs/logout_dialog.dart';
import 'package:cifraclub/presentation/screens/more/models/app_item.dart';
import 'package:cifraclub/presentation/screens/more/models/more_menu_item.dart';
import 'package:cifraclub/presentation/screens/more/models/social_network.dart';
import 'package:cifraclub/presentation/screens/more/more_bloc.dart';
import 'package:cifraclub/presentation/screens/more/more_state.dart';
import 'package:cifraclub/presentation/screens/more/widgets/more_installed_apps.dart';
import 'package:cifraclub/presentation/screens/more/widgets/more_menu.dart';
import 'package:cifraclub/presentation/screens/more/widgets/more_social_networks.dart';
import 'package:cifraclub/presentation/widgets/user_card.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class MoreScreen extends StatefulWidget {
  final List<MoreMenuItem> moreMenuList;
  final List<SocialNetwork> socialNetworkList;
  final List<AppItem> appList;

  const MoreScreen({
    super.key,
    required this.moreMenuList,
    required this.socialNetworkList,
    required this.appList,
  });

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late final MoreBloc _bloc = BlocProvider.of<MoreBloc>(context);
  var isSyncing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CosmosAppBar(
        toolbarHeight: context.appDimensionScheme.appBarHeight,
        title: Text(context.text.more, style: context.typography.title3),
        leading: null,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<MoreBloc, MoreState>(
        builder: (context, state) {
          return CustomScrollView(
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
                    onTap: () {
                      if (state.user != null) {
                        _bloc.openUserProfilePage();
                      } else {
                        _bloc.openLoginPage();
                      }
                    },
                  ),
                ),
              ),
              MoreMenu(
                  moreMenuList: widget.moreMenuList,
                  onClick: (item) {
                    if (item.isExternalDestination) {
                      _bloc.openUrl(item.destination);
                    } else {
                      Nav.of(context).push(screenName: item.destination);
                    }
                  }),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 32,
                    left: context.appDimensionScheme.screenMargin,
                    right: context.appDimensionScheme.screenMargin,
                    bottom: 16,
                  ),
                  child: Text(
                    context.text.ourApps,
                    style: context.typography.title3,
                  ),
                ),
              ),
              MoreInstalledApps(
                  allApps: widget.appList, onTap: _bloc.openAppOrStore, installedApps: state.installedApps),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 32,
                    left: context.appDimensionScheme.screenMargin,
                    right: context.appDimensionScheme.screenMargin,
                    bottom: 16,
                  ),
                  child: Text(
                    context.text.followCifraClub,
                    style: context.typography.title3,
                  ),
                ),
              ),
              MoreSocialNetworks(
                socialNetworks: widget.socialNetworkList,
                onTap: _bloc.openUrl,
              ),
            ],
          );
        },
      ),
    );
  }
}
