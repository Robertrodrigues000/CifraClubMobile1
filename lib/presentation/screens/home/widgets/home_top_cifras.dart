import 'package:flutter/material.dart';

class HomeTopCifras extends StatelessWidget {
  const HomeTopCifras({super.key, required this.list});

  final List<int> list;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: list.isNotEmpty ? list.length + 2 : 0, (context, index) {
        if (index == 0) {
          return const Text("Top Cifras");
        } else if (index == list.length + 1) {
          return const Text("Mais cifras");
        } else {
          return Card(
            child: Text("${list[index - 1]}"),
          );
        }
      }),
    );
  }
}
