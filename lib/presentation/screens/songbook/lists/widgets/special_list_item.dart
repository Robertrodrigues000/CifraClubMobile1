import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/presentation/widgets/selectable_item.dart';
import 'package:flutter/material.dart';

class SpecialListItem extends StatelessWidget {
  const SpecialListItem({
    super.key,
    required this.songbook,
    required this.onTap,
    this.isSelected = false,
  });

  final Songbook songbook;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SelectableItem(
      isSelected: isSelected,
      onTap: onTap,
      icon: ListType.getListIconAsset(songbook.type),
      text: ListType.getListTitle(context, songbook),
    );
  }
}
