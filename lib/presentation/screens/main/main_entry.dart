// coverage:ignore-file
import 'package:cifraclub/presentation/navigator/navigators_controller.dart';
import 'package:cifraclub/presentation/screens/main/main_bloc.dart';
import 'package:cifraclub/presentation/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class MainEntry extends StatefulWidget {
  const MainEntry({super.key, required this.navigatorsController});
  final NavigatorsController navigatorsController;

  @override
  State<MainEntry> createState() => _MainEntryState();
}

class _MainEntryState extends State<MainEntry> with RestorationMixin {
  late final pageController = PageController(
    initialPage: widget.navigatorsController.currentBottomNavigationScreen.index,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MainBloc();
      },
      child: MainScreen(
        navigatorsController: widget.navigatorsController,
        pageController: pageController,
        navFrameBuilder: (Nav nav) => NavFrame(nav: nav),
      ),
    );
  }

  @override
  String? get restorationId => "MainScreenEntryRestorationId";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(
      widget.navigatorsController.restorableBottomNavigationIndex,
      "BottomNavigationIndex",
    );
  }

  @override
  void dispose() {
    widget.navigatorsController.restorableBottomNavigationIndex.dispose();
    pageController.dispose();
    super.dispose();
  }
}
