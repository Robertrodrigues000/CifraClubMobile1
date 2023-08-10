// coverage:ignore-file
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/user_list_item.dart';
import 'package:flutter/material.dart';

class UserLists extends StatelessWidget {
  const UserLists({
    super.key,
    required this.lists,
    required this.onTap,
    this.onOptionsTap,
    this.selectedSongbookId,
  });
  final List<Songbook> lists;
  final Function(Songbook) onTap;
  final Function(Songbook)? onOptionsTap;
  final int? selectedSongbookId;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return UserListItem(
            key: Key(lists[index].name),
            onTap: () => onTap(lists[index]),
            // coverage:ignore-start
            onOptionsTap: onOptionsTap != null ? () => onOptionsTap!(lists[index]) : null,
            // coverage:ignore-end
            songbook: lists[index],
            isSelected: lists[index].id == selectedSongbookId,
          );
        },
        childCount: lists.length,
      ),
    );
  }
}
