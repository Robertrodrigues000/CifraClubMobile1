import 'package:cifraclub/presentation/screens/more/models/more_menu_item.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:flutter/material.dart';

class MoreMenu extends StatelessWidget {
  final List<MoreMenuItem> moreMenuList;
  final Function(MoreMenuItem) onClick;
  const MoreMenu({Key? key, required this.moreMenuList, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final item = moreMenuList[index];

          return IconTextTile(
            text: item.title,
            leadingIconAsset: item.imageAsset,
            onClick: () => onClick(item),
          );
        },
        childCount: moreMenuList.length,
      ),
    );
  }
}
