import 'package:flutter/material.dart';

class Highlights extends StatelessWidget {
  const Highlights({super.key, required this.list});

  final List<int> list;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 100,
              child: Card(
                child: Text("${list[index]}"),
              ),
            );
          },
        ),
      ),
    );
  }
}
