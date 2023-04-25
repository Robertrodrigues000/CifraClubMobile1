import 'dart:async';
import 'package:cifraclub/presentation/screens/main/main_bloc.dart';
import 'package:cifraclub/presentation/screens/main/main_state.dart';
import 'package:cifraclub/presentation/screens/main/widgets/main_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

typedef NavFrameBuilder = Widget Function(Nav nav);

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.pageController, required this.navFrameBuilder});

  final PageController pageController;
  final NavFrameBuilder navFrameBuilder;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  StreamSubscription? _blocStateSubscription;
  late MainBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<MainBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _blocStateSubscription?.cancel();
    _blocStateSubscription = bloc.stream.listen((event) {
      if (widget.pageController.page?.round() != event.selectedPage.index) {
        widget.pageController.jumpToPage(event.selectedPage.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        final safeAreaBottomOffset = MediaQuery.of(context).padding.bottom;
        return WillPopScope(
          onWillPop: bloc.onWillPop,
          child: Scaffold(
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: widget.pageController,
              children: List.generate(
                state.bottomNavigationNavs.length,
                (index) => widget.navFrameBuilder(state.bottomNavigationNavs[index]),
                growable: false,
              ),
            ),
            bottomNavigationBar: MainBottomNavigation(
              safeAreaBottomOffset: safeAreaBottomOffset,
              currentItem: state.selectedPage,
              onItemSelected: (selectedItem) {
                bloc.setSelectedItem(selectedItem);
                widget.pageController.jumpToPage(selectedItem.index);
              },
            ),
          ),
        );
      },
    );
  }
}
