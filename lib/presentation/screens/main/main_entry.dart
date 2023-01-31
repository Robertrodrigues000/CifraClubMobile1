// coverage:ignore-file
import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:cifraclub/presentation/screens/main/main_bloc.dart';
import 'package:cifraclub/presentation/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class MainEntry extends StatefulWidget {
  const MainEntry({super.key, required this.bottomNavigationPages});

  final List<Nav> bottomNavigationPages;

  @override
  State<MainEntry> createState() => _MainEntryState();
}

class _MainEntryState extends State<MainEntry> with RestorationMixin {
  final restorableBottomNavigationIndex = RestorableBottomNavigationItem();
  late final pageController = PageController(initialPage: restorableBottomNavigationIndex.value.index);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MainBloc(
          widget.bottomNavigationPages,
          restorableBottomNavigationIndex,
        );
      },
      child: MainScreen(
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
      restorableBottomNavigationIndex,
      "BottomNavigationIndex",
    );
  }

  @override
  void dispose() {
    restorableBottomNavigationIndex.dispose();
    pageController.dispose();
    super.dispose();
  }
}
