// coverage:ignore-file
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:flutter/material.dart';

class SpecialLists extends StatelessWidget {
  const SpecialLists({super.key, required this.lists});
  final List<Songbook> lists;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Text(lists[index].name);
        },
        childCount: lists.length,
      ),
    );
  }
}
