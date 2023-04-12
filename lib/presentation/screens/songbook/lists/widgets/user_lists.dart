// coverage:ignore-file
import 'package:flutter/material.dart';

class UserLists extends StatelessWidget {
  const UserLists({super.key, required this.list});
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Text(list[index]);
        },
        childCount: list.length,
      ),
    );
  }
}
