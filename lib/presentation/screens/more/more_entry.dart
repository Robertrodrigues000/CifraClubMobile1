// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/more/models/app_item.dart';
import 'package:cifraclub/presentation/screens/more/models/more_menu_item.dart';
import 'package:cifraclub/presentation/screens/more/models/social_network.dart';
import 'package:cifraclub/presentation/screens/more/more_bloc.dart';
import 'package:cifraclub/presentation/screens/more/more_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class MoreEntry extends ScreenEntry {
  static const name = "more";

  MoreEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MoreBloc>(
      create: (context) => MoreBloc(getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt()),
      child: MoreScreen(
        moreMenuList: MoreMenuItem.getAll(context),
        socialNetworkList: SocialNetwork.getAll(context),
        appList: AppItem.getAllApps(context),
      ),
    );
  }
}
