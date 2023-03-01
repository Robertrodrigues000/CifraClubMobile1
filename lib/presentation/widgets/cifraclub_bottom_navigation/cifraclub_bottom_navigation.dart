import 'package:cifraclub/extensions/iterable.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class CifraclubBottomNavigation extends StatefulWidget {
  const CifraclubBottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  }) : super(key: key);

  final int currentIndex;
  final void Function(int index) onTap;
  final List<BottomNavigationBarItem> items;

  @override
  State<CifraclubBottomNavigation> createState() => _CifraclubBottomNavigationState();
}

class _CifraclubBottomNavigationState extends State<CifraclubBottomNavigation> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.items.length, vsync: this, initialIndex: widget.currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = CosmosColorScheme.of(context);
    const double indicatorHorizontalPadding = 12;
    const double indicatorHeight = 3;
    const double topBorderHeight = 1;
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          Container(
            color: colors.neutralTertiary,
            height: topBorderHeight,
          ),
          TabBar(
            controller: _tabController,
            labelPadding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.only(
                bottom: constraints.maxHeight - indicatorHeight,
                left: indicatorHorizontalPadding,
                right: indicatorHorizontalPadding),
            indicatorWeight: 0,
            indicator: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(1.5)),
            onTap: widget.onTap,
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.resolveWith((_) => Colors.transparent),
            tabs: widget.items
                .mapIndexed((e, index) => CifraClubBottomNavigationTile(
                      activeIcon: e.activeIcon,
                      icon: e.icon,
                      label: e.label,
                      isSelected: index == widget.currentIndex,
                      selectedIconTheme: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!,
                      unselectedIconTheme: Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme!,
                      selectedLabelStyle: Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle!,
                      unselectedLabelStyle: Theme.of(context).bottomNavigationBarTheme.unselectedLabelStyle!,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class CifraClubBottomNavigationTile extends StatelessWidget {
  const CifraClubBottomNavigationTile({
    Key? key,
    this.icon,
    this.activeIcon,
    this.label,
    required this.isSelected,
    required this.selectedIconTheme,
    required this.unselectedIconTheme,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
  }) : super(key: key);
  final Widget? icon;
  final Widget? activeIcon;
  final String? label;
  final bool isSelected;
  final IconThemeData selectedIconTheme;
  final IconThemeData unselectedIconTheme;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;

  @override
  Widget build(BuildContext context) {
    const double tileTopPadding = 10;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: tileTopPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (icon != null && !isSelected) IconTheme(data: unselectedIconTheme, child: icon!),
            if (activeIcon != null && isSelected) IconTheme(data: selectedIconTheme, child: activeIcon!),
            if (label != null)
              Text(
                label!,
                style: isSelected ? selectedLabelStyle : unselectedLabelStyle,
              ),
          ],
        ),
      ),
    );
  }
}
