import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_bottom_navigation.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';

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
    final mediaQuery = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQuery.copyWith(textScaleFactor: 1.0),
      child: SizedBox(
        height: bottomNavigationHeight + safeAreaBottomOffset,
        child: CifraclubBottomNavigation(
          currentIndex: currentItem.index,
          onTap: (index) => onItemSelected(BottomNavigationItem.values[index]),
          items: [
            BottomNavigationBarItem(
              icon: SvgImage(
                assetPath: AppSvgs.homeBottomNavIcon,
                height: 24,
                width: 24,
                color: context.colors.neutralSextenary,
              ),
              activeIcon: SvgImage(
                assetPath: AppSvgs.homeBottomNavIcon,
                height: 24,
                width: 24,
                color: context.colors.textPrimary,
              ),
              label: context.text.home,
            ),
            BottomNavigationBarItem(
              icon: SvgImage(
                assetPath: AppSvgs.songbookBottomNavIcon,
                height: 24,
                width: 24,
                color: context.colors.neutralSextenary,
              ),
              activeIcon: SvgImage(
                assetPath: AppSvgs.songbookBottomNavIcon,
                height: 24,
                width: 24,
                color: context.colors.textPrimary,
              ),
              label: context.text.songbook,
            ),
            BottomNavigationBarItem(
              icon: SvgImage(
                assetPath: AppSvgs.searchBottomNavIcon,
                height: 24,
                width: 24,
                color: context.colors.neutralSextenary,
              ),
              activeIcon: SvgImage(
                assetPath: AppSvgs.searchBottomNavIcon,
                height: 24,
                width: 24,
                color: context.colors.textPrimary,
              ),
              label: context.text.search,
            ),
            BottomNavigationBarItem(
              icon: SvgImage(
                assetPath: AppSvgs.academyBottomNavIcon,
                height: 24,
                width: 24,
                color: context.colors.neutralSextenary,
              ),
              activeIcon: SvgImage(
                assetPath: AppSvgs.academyBottomNavIcon,
                height: 24,
                width: 24,
                color: context.colors.textPrimary,
              ),
              label: context.text.academy,
            ),
            BottomNavigationBarItem(
              icon: SvgImage(
                assetPath: AppSvgs.moreBottomNavIcon,
                height: 24,
                width: 24,
                color: context.colors.neutralSextenary,
              ),
              activeIcon: SvgImage(
                assetPath: AppSvgs.moreBottomNavIcon,
                height: 24,
                width: 24,
                color: context.colors.textPrimary,
              ),
              label: context.text.more,
            ),
          ],
        ),
      ),
    );
  }
}
