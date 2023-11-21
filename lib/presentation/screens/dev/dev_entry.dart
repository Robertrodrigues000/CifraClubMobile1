// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:nav/nav.dart';
import 'package:cifraclub/presentation/screens/dev/dev_screen.dart';
import 'package:cifraclub/presentation/screens/dev/dev_screen_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DevScreenEntry extends ScreenEntry {
  static const name = "devScreen";

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  DevScreenEntry(super.params);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DevScreenBloc(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
      child: DevScreen(
        getCredentialsStream: getIt(),
        logout: getIt(),
        openLoginView: getIt(),
        openUserProfilePage: getIt(),
        devBottomSheet: getIt(),
      ),
    );
  }
}
