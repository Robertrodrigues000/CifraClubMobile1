import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_bottom_navigation/cifraclub_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class MainBottomNavigation extends StatelessWidget {
  static const double bottomNavigationHeight = 56;

  final BottomNavigationItem currentItem;
  final double safeAreaBottomOffset;
  final void Function(BottomNavigationItem selectedItem) onItemSelected;

  const MainBottomNavigation(
      {Key? key, required this.currentItem, required this.onItemSelected, this.safeAreaBottomOffset = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: bottomNavigationHeight + safeAreaBottomOffset,
      child: CifraclubBottomNavigation(
        currentIndex: currentItem.index,
        onTap: (index) => onItemSelected(BottomNavigationItem.values[index]),
        items: [
          BottomNavigationBarItem(
            icon: const ImageIcon(
              Svg(AppSvgs.homeBottomNavIcon),
              size: 24,
            ),
            activeIcon: const ImageIcon(
              Svg(AppSvgs.homeBottomNavIcon),
              size: 24,
            ),
            label: context.text.home,
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(
              Svg(AppSvgs.songbookBottomNavIcon),
              size: 24,
            ),
            activeIcon: const ImageIcon(
              Svg(AppSvgs.songbookBottomNavIcon),
              size: 24,
            ),
            label: context.text.songbook,
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(
              Svg(AppSvgs.searchBottomNavIcon),
              size: 24,
            ),
            activeIcon: const ImageIcon(
              Svg(AppSvgs.searchBottomNavIcon),
              size: 24,
            ),
            label: context.text.search,
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(
              Svg(AppSvgs.academyBottomNavIcon),
              size: 24,
            ),
            activeIcon: const ImageIcon(
              Svg(AppSvgs.academyBottomNavIcon),
              size: 24,
            ),
            label: context.text.academy,
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(
              Svg(AppSvgs.moreBottomNavIcon),
              size: 24,
            ),
            activeIcon: const ImageIcon(
              Svg(AppSvgs.moreBottomNavIcon),
              size: 24,
            ),
            label: context.text.more,
          ),
        ],
      ),
    );
  }
}
