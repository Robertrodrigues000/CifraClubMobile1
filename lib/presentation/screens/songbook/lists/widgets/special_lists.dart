import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/special_list_item.dart';
import 'package:flutter/material.dart';

class SpecialLists extends StatelessWidget {
  const SpecialLists({super.key, required this.lists, this.selectedSongbookId, required this.onTap});
  final List<Songbook> lists;
  final int? selectedSongbookId;
  final Function(Songbook) onTap;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final songbook = lists[index];
          return SpecialListItem(
            key: Key(songbook.name),
            songbook: songbook,
            onTap: () => onTap(songbook),
            isSelected: songbook.id == selectedSongbookId,
          );
        },
        childCount: lists.length,
      ),
    );
  }
}
