// coverage:ignore-file
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_operation_dialogs/edit_mode_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/user_list_item.dart';
import 'package:flutter/material.dart';

class UserLists extends StatelessWidget {
  const UserLists({super.key, required this.lists, required this.onTap});
  final List<Songbook> lists;
  final Function(Songbook) onTap;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return UserListItem(
            key: Key(lists[index].name),
            onTap: () => onTap(lists[index]),
            // coverage:ignore-start
            onOptionsTap: () async {
              final result = await EditModeDialog.show(context);
              // ignore: avoid_print
              print(result);
            },
            // coverage:ignore-end
            songbook: lists[index],
            isSelected: index == 1,
          );
        },
        childCount: lists.length,
      ),
    );
  }
}
