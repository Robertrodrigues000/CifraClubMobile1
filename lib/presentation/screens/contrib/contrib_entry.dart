// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/contrib/contrib_screen.dart';
import 'package:cifraclub/presentation/screens/contrib/contrib_screen_bloc.dart';
import 'package:nav/nav.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContribScreenEntry extends ScreenEntry {
  static const name = "contribScreen";

  static void push(Nav nav) {
    nav.push(screenName: name);
  }

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  ContribScreenEntry(super.params);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContribScreenBloc(
        getIt(),
      ),
      child: const ContribScreen(),
    );
  }
}
