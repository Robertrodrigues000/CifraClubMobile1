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
    required this.validatePreview,
  });
  final List<Songbook> lists;
  final Function(Songbook) onTap;
  final Function(Songbook)? onOptionsTap;
  final List<String> Function(List<String?>) validatePreview;
  final int? selectedSongbookId;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final songbook = lists[index];
          return UserListItem(
            key: Key(songbook.name),
            onTap: () => onTap(songbook),
            // coverage:ignore-start
            onOptionsTap: onOptionsTap != null ? () => onOptionsTap!(songbook) : null,
            // coverage:ignore-end
            songbook: songbook,
            isSelected: songbook.id == selectedSongbookId,
            preview: validatePreview(songbook.preview),
          );
        },
        childCount: lists.length,
      ),
    );
  }
}
