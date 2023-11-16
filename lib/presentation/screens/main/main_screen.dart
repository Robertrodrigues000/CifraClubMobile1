import 'package:cifraclub/presentation/navigator/navigators_controller.dart';
import 'package:cifraclub/presentation/screens/main/main_bloc.dart';
import 'package:cifraclub/presentation/screens/main/main_state.dart';
import 'package:cifraclub/presentation/screens/main/widgets/main_bottom_navigation.dart';
import 'package:cifraclub/presentation/screens/version/version_entry.dart';
import 'package:cifraclub/presentation/widgets/back_button_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

typedef NavFrameBuilder = Widget Function(Nav nav);

class MainScreen extends StatefulWidget {
  const MainScreen(
      {super.key, required this.pageController, required this.navFrameBuilder, required this.navigatorsController});

  final PageController pageController;
  final NavFrameBuilder navFrameBuilder;
  final NavigatorsController navigatorsController;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainBloc bloc;
  var shouldShowBottomNavigation = true;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<MainBloc>(context);
    _verifyCurrentScreen();

    widget.navigatorsController.addNavListener(_verifyCurrentScreen);
  }

  @override
  void didChangeDependencies() {
    widget.navigatorsController.restorableBottomNavigationIndex.addListener(_listenToBottomNavigationSelectedItem);
    super.didChangeDependencies();
  }

  // coverage:ignore-start
  void _listenToBottomNavigationSelectedItem() {
    final selectedItem = widget.navigatorsController.currentBottomNavigationScreen;
    if (widget.pageController.page?.round() != selectedItem.index) {
      widget.pageController.jumpToPage(selectedItem.index);
    }
  }
  // coverage:ignore-end

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        final safeAreaBottomOffset = MediaQuery.of(context).padding.bottom;
        return BackButtonHandler(
          onWillPop: widget.navigatorsController.onWillPop,
          child: Scaffold(
              body: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: widget.pageController,
                children: List.generate(
                  widget.navigatorsController.navs.length,
                  (index) => widget.navFrameBuilder(widget.navigatorsController.navs[index]),
                  growable: false,
                ),
              ),
              bottomNavigationBar: AnimatedBuilder(
                animation: widget.navigatorsController.restorableBottomNavigationIndex,
                builder: (context, _) {
                  return shouldShowBottomNavigation
                      ? MainBottomNavigation(
                          key: const Key("bottomNav"),
                          safeAreaBottomOffset: safeAreaBottomOffset,
                          onItemSelected: (selectedItem) {
                            widget.navigatorsController.setSelectedItem(selectedItem);
                          },
                          currentItem: widget.navigatorsController.currentBottomNavigationScreen,
                        )
                      : const SizedBox();
                },
              )),
        );
      },
    );
  }

  void _verifyCurrentScreen() {
    final isVersionEntry = widget.navigatorsController.currentScreen?.screenName == VersionEntry.name;

    if (!isVersionEntry && shouldShowBottomNavigation) {
      return;
    }

    setState(() {
      shouldShowBottomNavigation = !isVersionEntry;
    });
  }

  @override
  void dispose() {
    widget.navigatorsController.restorableBottomNavigationIndex.removeListener(_listenToBottomNavigationSelectedItem);
    super.dispose();
  }
}
