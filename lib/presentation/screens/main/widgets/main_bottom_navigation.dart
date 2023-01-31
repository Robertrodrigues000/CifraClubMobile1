import 'package:cifraclub/presentation/screens/main/bottom_navigation_item.dart';
import 'package:cifraclub/presentation/style/app_color_scheme/app_colors.dart';
import 'package:flutter/material.dart';

class MainBottomNavigation extends StatelessWidget {
  static const double bottomNavigationHeight = 56;

  final BottomNavigationItem currentItem;
  final double safeAreaBottomOffset;
  final void Function(BottomNavigationItem selectedItem) onItemSelected;

  const MainBottomNavigation({Key? key, required this.currentItem, required this.onItemSelected, this.safeAreaBottomOffset = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: bottomNavigationHeight + safeAreaBottomOffset,
      child: BottomNavigationBar(
        currentIndex: currentItem.index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.grey90,
        selectedFontSize: 12.0,
        unselectedFontSize: 10.0,
        backgroundColor: AppColors.grey10,
        onTap: (index) => onItemSelected(BottomNavigationItem.values[index]),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.house), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.developer_mode), label: "Dev"),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: "Artist"),
        ],
      ),
    );
  }
}
