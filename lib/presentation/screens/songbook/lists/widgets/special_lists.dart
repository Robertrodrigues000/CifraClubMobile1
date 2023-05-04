import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/special_list_item.dart';
import 'package:flutter/material.dart';

class SpecialLists extends StatelessWidget {
  const SpecialLists({super.key, required this.lists});
  final List<Songbook> lists;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return SpecialListItem(
            key: Key(lists[index].name),
            type: lists[index].type,
            // coverage:ignore-start
            onTap: () {}, // TODO: Navigate to the special list selected
            // coverage:ignore-end
            isSelected: index == 1,
          );
        },
        childCount: lists.length,
      ),
    );
  }
}
